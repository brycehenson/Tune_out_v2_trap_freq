% fit combined 2p scans to find linewidth as function of time

addpath('../../lib/Core_BEC_Analysis/lib/') %add the path to set_up_project_path
set_up_project_path('../..')



% data 
% TOV2/20190101_2p_cs_wm_stab
% - looks like an hour and a half of measurements
% 20181231_2p_cs_wm_stab_two


% TODO
% plot of fit params over interogation
% calulate thermal width of CS
% calculate laser noise from std profile fits
% calculate allan deviation of locked laser
% combine interogations
% combine with wavemeter log data

%%
data_dir='E:\scratch\to_wm_stab';
file_name='2p_cs_log_20181231T014329.txt'
path=fullfile(data_dir,file_name);
fid = fopen(path,'r');
raw_lines = textscan(fid,'%s','Delimiter','\n'); % this is the fastest string read method 3.5s for 20 files
fclose(fid);
raw_lines=raw_lines{1};


% i think the usual params were %0.3s for settle time 0.7 for aq time
% 500hz az with 3.7khz low pass filter
num_samples_guess=0.5*500;

%%
iimax=numel(raw_lines);
scans_data=cell(1,iimax);
for ii=1:iimax
    scans_data{ii}=jsondecode(raw_lines{ii});
end


%% fit a single scan with a voigt
pmt_gain=20e6;
rescale_curr_mult=1e9;
ii=14;

pmt_gain=pmt_gain*-1;
single_scan_dat=scans_data{ii};
rel_samp_time=single_scan_dat.parameters.sample_time_posix;
start_samp_time=rel_samp_time(1); %posix time is first entry
rel_samp_time(1)=0;
aq_cen_time=mean(rel_samp_time)+start_samp_time;

set_freq=single_scan_dat.parameters.set_freq;

pmt_curr_mean=single_scan_dat.parameters.pmt_voltage_mean/pmt_gain;
pmt_curr_std=single_scan_dat.parameters.pmt_voltage_std/pmt_gain;
pmt_curr_ste=pmt_curr_std/sqrt(num_samples_guess);
mean_freq=mean(set_freq);

predictor=set_freq-mean_freq;
response=pmt_curr_mean*rescale_curr_mult;
opts=[];
opts.predictor=predictor;
opts.response=response;
opts.response_err=pmt_curr_ste*rescale_curr_mult;
opts.do_plots=true;
opts.sigma_outlier=outlier_thresh;
tmp_out_st=fit_2p_data_with_a_voigt(opts);
export_fig('E:\Dropbox\UNI\projects\programs\tune_out_v2\Tune_out_git\results\2p_nice_plots\2p_nice_plot.svg')

%%
% errorbar(set_freq-mean_freq,pmt_curr_mean*plot_curr_mult,pmt_curr_std*plot_curr_mult,'x')
% xlabel('MHz')
% ylabel('nA')
%% fit each scan with a voigt
% rescale so x is zero mean
% deterimine if data points are outliers
rescale_curr_mult=1e9;
pmt_gain=20e6;
pmt_gain=pmt_gain*-1;
outlier_thresh=3.5;

fprintf('\nfitting scans ')
output_chars=fprintf('%04u of %04u',0,iimax);

proc_scans=[];
iimax=numel(scans_data);
vf_out=[];
for ii=1:iimax
    fprintf(repmat('\b',[1,output_chars]))
    output_chars=fprintf('%04u of %04u',ii,iimax);
    
    single_scan_dat=scans_data{ii};
    rel_samp_time=single_scan_dat.parameters.sample_time_posix;
    start_samp_time=rel_samp_time(1); %posix time is first entry
    rel_samp_time(1)=0;
    aq_cen_time=mean(rel_samp_time)+start_samp_time;

    set_freq=single_scan_dat.parameters.set_freq;

    pmt_curr_mean=single_scan_dat.parameters.pmt_voltage_mean/pmt_gain;
    pmt_curr_std=single_scan_dat.parameters.pmt_voltage_std/pmt_gain;
    pmt_curr_ste=pmt_curr_std/sqrt(num_samples_guess);
    mean_freq=mean(set_freq);

    predictor=set_freq-mean_freq;
    response=pmt_curr_mean*rescale_curr_mult;

    opts=[];
    opts.predictor=predictor;
    opts.response=response;
    opts.do_plots=false;
    opts.sigma_outlier=outlier_thresh;
    tmp_out_st=fit_2p_data_with_a_voigt(opts);
    tmp_out_st.offset_freq=mean_freq;
    tmp_out_st.time_aq=aq_cen_time;
    vf_out{ii}=tmp_out_st;

    pause(0.5)

end
fprintf('\n')

%% Plot the fit history
% lets wrangle thse fits into a nice matrix to plot
plot_fit_singles=[];
iimax=numel(vf_out);
plot_fit_singles.coef.val=nan(iimax,5);
plot_fit_singles.coef.se=nan(iimax,5);
plot_fit_singles.time=nan(iimax,1);
for ii=1:iimax
    this_fit=vf_out{ii};
    if ~isempty(this_fit.fit_cull)
        plot_fit_singles.coef.val(ii,:)=this_fit.fit_cull.voigt.Coefficients.Estimate;
        % add the freq offset
        plot_fit_singles.coef.val(ii,3)=plot_fit_singles.coef.val(ii,3)+this_fit.offset_freq;
        plot_fit_singles.coef.se(ii,:)=this_fit.fit_cull.voigt.Coefficients.SE;
        plot_fit_singles.time(ii)=this_fit.time_aq;
    end
end

%%
stfig('fit history')
clf
time_scaling=1/(60*60);
filt_time=60*5;
start_time=min(plot_fit_singles.time);
subplot(3,1,1)
raw_sigma=plot_fit_singles.coef.val(:,1);
raw_gamma=plot_fit_singles.coef.val(:,2);
raw_freq=plot_fit_singles.coef.val(:,3);
valid_mask=~isnan(raw_sigma) & raw_sigma>0.01 & raw_sigma<0.4 & raw_gamma>0.3;

raw_sigma=raw_sigma(valid_mask);
raw_gamma=raw_gamma(valid_mask);
raw_freq=raw_freq(valid_mask);

time_raw=plot_fit_singles.time-start_time;
time_masked=time_raw(valid_mask);
smooth_sigma=gaussfilt(time_masked,raw_sigma,filt_time);
smooth_gamma=gaussfilt(time_masked,raw_gamma,filt_time);
plot(time_masked*time_scaling,raw_sigma)
hold on
plot(time_masked*time_scaling,smooth_sigma)
hold off
ylabel('$\sigma$ (MHz)')
subplot(3,1,2)
plot(time_masked*time_scaling,raw_gamma)
hold on
plot(time_masked*time_scaling,smooth_gamma)
hold off
ylabel('$\gamma$ (MHz)')
subplot(3,1,3)
mean_freq=nanmean(raw_freq);
plot(time_masked*time_scaling,raw_freq-mean_freq)
ylabel('$\mu$ (MHz)')
xlabel('time (h)')

%% lets look at the allan deviation 
allan_data=[]
allan_data.freq=raw_freq-mean_freq;
allan_data.time=time_masked;
tau=logspace(log10(200),log10(20e3));
[adev, s, errorb, tau]=allan_overlap(allan_data,tau,[],1)


%% time integerated standard deviation
%tau=logspace(log10(200),log10(range(time_masked)/2.1),100);
tau=logspace(log10(600),log10(range(time_masked)/2.1),100);
[int_sdev,int_sdev_unc]=time_integerated_sdev(time_masked,raw_freq-mean_freq,tau);

stfig('int stdev');
clf


% cof_names={'grad','offset'};
% fit_fun=@(b,x) b(1)*log(x)+b(2);
% beta0=[0.1,0.01];

% cof_names={'offset','grad'};
% fit_fun=@(b,x) b(1)+b(2)*log(x);
% beta0=[0.1,0.01];

cof_names={'offset','grad','curve'};
fit_fun=@(b,x) b(1)+b(2)*log(x)+b(3)*(log(x)).^2;
beta0=[0.1,0.01,0.01];

predictor=tau;
response=int_sdev;


opt = statset('TolFun',1e-10,'TolX',1e-10,...
    'MaxIter',1e4,... %1e4
    'UseParallel',1);

weights=ones(size(predictor));
% weights=1./int_sdev_unc;
% weights(isnan(weights))=1e-20; %if nan then set to smallest value you can
% weights=weights./sum(weights);
% 

fitobj=fitnlm(predictor,response,fit_fun,beta0,...
    'options',opt,...
    'Weights',weights,...
    'CoefficientNames',cof_names);

%
xplotvalues=linspace(min(predictor),max(predictor),1e4);
xplotvalues=col_vec(xplotvalues);
amp_pred=fitobj.predict(xplotvalues); %'Alpha',1-erf(1/sqrt(2)),'Prediction','observation'


[amp_pred,ci]=predict(fitobj,xplotvalues,'Alpha',1-erf(1/sqrt(2)),'Prediction','observation'); %'Alpha',1-erf(1/sqrt(2)),'Prediction','observation'
[~,ci_curve]=fitobj.predict(xplotvalues,'Alpha',1-erf(1/sqrt(2)),'Prediction','curve'); %

shaded_ci_lines=true;
color_shaded=[0.9,1,1];


hold on
if shaded_ci_lines
    patch([xplotvalues', fliplr(xplotvalues')], [ci(:,1)', fliplr(ci(:,2)')], color_shaded,'EdgeColor','none')  %[1,1,1]*0.80
else
    plot(xplotvalues,ci(:,1),'-','LineWidth',1.5)
    plot(xplotvalues,ci(:,2),'-','LineWidth',1.5)
end  

shaded_curve_ci_lines=false;
if shaded_curve_ci_lines
    color_shaded=[0.9,1,1];
    patch([xplotvalues', fliplr(tplotvalues')], [ci_curve(:,1)', fliplr(ci_curve(:,2)')], color_shaded,'EdgeColor','none')  %[1,1,1]*0.80
    hold on
else
    color_shaded=[0,1,0];
    plot(xplotvalues,ci_curve(:,1),'-','LineWidth',1.5,'Color',color_shaded)
    hold on
    plot(xplotvalues,ci_curve(:,2),'-','LineWidth',1.5,'Color',color_shaded)
end  

errorbar(tau,int_sdev,int_sdev_unc,'xk','capsize',0)
%set(gca,'YScale','Log')

plot(xplotvalues,amp_pred,'-','LineWidth',1.0)
set(gca,'XScale','Log')
%set(gca,'YScale','Log')
xlabel('integeration time (s)')
ylabel('sample standard deviation (MHz)')
hold off



%% lets integerate a variable amount and then fit the result

fprintf('\n fitting integeration of scans ')
output_chars=fprintf('%04u of %04u',0,iimax);

fits_varying_int={};
%int_max_schedule=10:10:numel(vf_out)-1;
int_start=2;
int_max_schedule=1:20:numel(vf_out)-int_start;

iimax=numel(int_max_schedule);
for ii=1:iimax
    fprintf(repmat('\b',[1,output_chars]))
    output_chars=fprintf('%04u of %04u',ii,iimax);
    cen_times=[];
    set_freqs=[];
    pmt_mean_currs=[];
    for jj=int_start:(int_start+int_max_schedule(ii))
        single_scan_dat=vf_out{jj};
        this_set_freqs=single_scan_dat.data_cull.predictor+single_scan_dat.offset_freq;
        this_mean_curr=single_scan_dat.data_cull.response;
        % if fit_cull is empty then the fit went haywire
        if ~isempty(single_scan_dat.fit_cull)
            mean_current=single_scan_dat.fit_cull.voigt.Coefficients.Estimate(5);
            this_mean_curr=this_mean_curr-mean_current;
            pmt_mean_currs=cat(1,pmt_mean_currs,this_mean_curr);
            set_freqs=cat(1,set_freqs,this_set_freqs);
            cen_times=cat(1,cen_times,single_scan_dat.time_aq);
        end
    end

    %size(set_freqs)

    mean_freq=mean(set_freqs);

    % errorbar(set_freq-mean_freq,pmt_curr_mean*rescale_curr_mult,pmt_curr_std*rescale_curr_mult,'x')
    % xlabel('MHz')
    % ylabel('nA')
    % %

    predictor=set_freqs-mean_freq;
    response=pmt_mean_currs;
    % fit to all the data without binning
%     opts=[];
%     opts.predictor=predictor;
%     opts.response=response;
%     opts.do_plots=true;
%      opts.sigma_outlier=4;
%     combined_fit_out=fit_2p_data_with_a_voigt(opts)

    % what if i bin it first then fit


    binning_opts=[];
    binning_opts.x=predictor;
    binning_opts.y=response;
    binning_opts.xbin_edges=linspace(min(predictor),max(predictor),100);
    bined_data=bin_xy_data(binning_opts);

    % 200
    % 0.23794
    % 0.49984
    % 500
    % 0.23234
    % 0.50246
    % 1000
    % 0.23183
    % 0.50274


    %
    opts=[];
    opts.predictor=bined_data.x.mean;
    opts.response=bined_data.y.mean;
    opts.do_plots=true;
    opts.sigma_outlier=4;
    tmp_int_out=fit_2p_data_with_a_voigt(opts);
    tmp_int_out.time_range=range(cen_times);
    tmp_int_out.cen_times=cen_times;
    tmp_int_out.offset_freq= mean_freq;
    fits_varying_int{ii}=tmp_int_out;
end

%% Plot the integeration dependence

plot_fit_int=[];
iimax=numel(fits_varying_int);
plot_fit_int.coef.val=nan(iimax,5);
plot_fit_int.coef.se=nan(iimax,5);
plot_fit_int.time_range=nan(iimax,1);

for ii=1:iimax
    this_int_fit=fits_varying_int{ii};
    if ~isempty(this_int_fit.fit_no_cull)
        plot_fit_int.coef.val(ii,:)=this_int_fit.fit_no_cull.voigt.Coefficients.Estimate;
        plot_fit_int.coef.se(ii,:)=this_int_fit.fit_no_cull.voigt.Coefficients.SE;
        % add the freq offset to mu
        plot_fit_int.coef.val(ii,3)=plot_fit_int.coef.val(ii,3)+this_int_fit.offset_freq;
        plot_fit_int.time_range(ii)=this_int_fit.time_range;
    end
end

stfig('int dependence');
clf
time_scaling=1/(60*60);
subplot(3,1,1)
errorbar(params.time_range*time_scaling,plot_fit_int.coef.val(:,1),plot_fit_int.coef.se(:,1),'xk','CapSize',0)
ylabel('$\sigma$ (MHz)')
ylim([0.15,0.25])
subplot(3,1,2)
errorbar(params.time_range*time_scaling, plot_fit_int.coef.val(:,2),plot_fit_int.coef.se(:,2),'xk','CapSize',0)
ylabel('$\gamma$ (MHz)')
ylim([0.45,0.55])
subplot(3,1,3)
mean_freq=nanmean(plot_fit_int.coef.val(:,3));
errorbar(params.time_range*time_scaling, plot_fit_int.coef.val(:,3)-mean_freq,plot_fit_int.coef.se(:,3),'xk','CapSize',0)
ylabel('$\mu$ (MHz)')

xlabel('integrated time (h)')



%% crude implementation no offset correction done
% now lets see what happens when we combine data
pmt_gain=20e6;
pmt_gain=pmt_gain*-1; %to make a positive point
rescale_curr_mult=1e9;

cen_times=[];
set_freqs=[];
pmt_mean_currs=[];
for ii=[2,500]
single_scan_dat=scans_data{ii};
rel_samp_time=single_scan_dat.parameters.sample_time_posix;
start_samp_time=rel_samp_time(1); %posix time is first entry
rel_samp_time(1)=0;
this_aq_cen_time=mean(rel_samp_time)+start_samp_time;
this_set_freq=single_scan_dat.parameters.set_freq;
this_pmt_curr_mean=single_scan_dat.parameters.pmt_voltage_mean/pmt_gain;
this_pmt_curr_std=single_scan_dat.parameters.pmt_voltage_std/pmt_gain;
cen_times=cat(1,cen_times,this_aq_cen_time);
set_freqs=cat(1,set_freqs,this_set_freq);
pmt_mean_currs=cat(1,pmt_mean_currs,this_pmt_curr_mean);
end


size(set_freqs)

mean_freq=mean(set_freqs);

errorbar(set_freq-mean_freq,pmt_curr_mean*rescale_curr_mult,pmt_curr_std*rescale_curr_mult,'x')
xlabel('MHz')
ylabel('nA')
%

predictor=set_freqs-mean_freq;
response=pmt_mean_currs*rescale_curr_mult;
opts=[];
opts.predictor=predictor;
opts.response=response;
fit_some_data_with_a_voigt(opts)


