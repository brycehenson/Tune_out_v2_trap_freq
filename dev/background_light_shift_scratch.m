%background light shift scratch
% calculate the freq diff from tune out at which the frac. error in the dyn. polz. hits 10%
% convert between derivatives given as per nm into per hz

hebec_constants
global const
%%

dyn_polz_deriv_nm.vals=[0,-1.913,-454.79,-2.04e5,-1.19e8];
dyn_polz_deriv_nm.units='a_0^3 nm^(n)';
frac_diff_series=@(x) abs((taylor_series(x,dyn_polz_deriv_nm.vals,0)-taylor_series(x,dyn_polz_deriv_nm.vals(1:2),0))./taylor_series(x,dyn_polz_deriv_nm.vals,0));


plot_x_factor=1e3;
xsamp_nm=linspace(-1e-3,1e-3,1e3);
polz_full_nm=taylor_series(xsamp_nm,dyn_polz_deriv_nm.vals,0);
polz_first_nm=taylor_series(xsamp_nm,dyn_polz_deriv_nm.vals(1:2),0);
stfig('first order comparison');
clf
subplot(2,1,1)
plot(plot_x_factor*xsamp_nm,polz_full_nm)
hold on
plot(plot_x_factor*xsamp_nm,polz_first_nm)
ylabel('Polarizability \alpha(\omega) (a_{0}^3)')
xlabel('detuning from TO(pm)')
hold off
subplot(2,1,2)
plot(plot_x_factor*xsamp_nm,abs((polz_first_nm-polz_full_nm)./polz_full_nm))
ylabel('fractional difference')
xlabel('detuning from TO(pm)')
hold on


plot(plot_x_factor*xsamp_nm,frac_diff_series(xsamp_nm))
hold off


%%

fminbnd(@(x) abs(frac_diff_series(x)-0.1),0,2e-3)
fminbnd(@(x) abs(frac_diff_series(x)-0.1) ,-2e-3,0)

%% convert into meters
dyn_polz_deriv_m.vals=dyn_polz_deriv_nm.vals.*(1e9.^(0:(numel(dyn_polz_deriv_nm.vals)-1)));
dyn_polz_deriv_m.units='a_0^3 m^(n)';
frac_diff_series=@(x) abs((taylor_series(x,dyn_polz_deriv_m.vals,0)-taylor_series(x,dyn_polz_deriv_m.vals(1:2),0))./taylor_series(x,dyn_polz_deriv_m.vals,0));


plot_x_factor=1e12;
xsamp_m=linspace(-1e-12,1e-12,1e3);
polz_full_m=taylor_series(xsamp_m,dyn_polz_deriv_m.vals,0);
polz_first_m=taylor_series(xsamp_m,dyn_polz_deriv_m.vals(1:2),0);
ylabel('Polarizability \alpha(\omega) (a_{0}^3)')
stfig('first order comparison')
clf
subplot(2,1,1)
plot(plot_x_factor*xsamp_m,polz_full_m)
hold on
plot(plot_x_factor*xsamp_m,polz_first_m)
xlabel('detuning from TO(pm)')
hold off
subplot(2,1,2)
plot(plot_x_factor*xsamp_m,abs((polz_first_m-polz_full_m)./polz_full_m))
ylabel('fractional difference')
xlabel('detuning from TO(pm)')
hold on


plot(plot_x_factor*xsamp_m,frac_diff_series(xsamp_m))
hold off



%% convert derivatives into frequency

% f = c/\lambda
% we use chain rule to for a change of vairables from wavelength to freq
% consider the operator d / d \omega
% we can expand with chain rule to be d/d \omega = d/d\lambda � d \lambda/d\omega
% and the nth deriviative can be found by applying the operator many times d^n/d \omega^n = d^n/d\lambda^n � ...
% (d \lambda/d\omega)^2

% note: here my first instinct of using a hirger oder chain rule is wrong, from what i can tell chain rull only works for the first derivative

% d alpha/d lambda  * d lambda/d omega= d alpha/ d omega
% 
% lamda = c/freq
% d lamdba /d omega = -c* freq^-2
% then 

freq_to=725736812e6;
d_lambda_over_domega= -const.c.*freq_to.^(-2);


%dyn_polz_deriv_freq.vals=dn_lambda_over_domega_n(freq_to,0:4).*dyn_polz_deriv_m.vals;
dyn_polz_deriv_freq.vals=dyn_polz_deriv_m.vals.*d_lambda_over_domega.^(0:numel(dyn_polz_deriv_m.vals)-1);
dyn_polz_deriv_nm.units='a_0^3 hz^(-n)';

%%
samp_range_hz=[min(xsamp_m),max(xsamp_m)]./dn_lambda_over_domega_n(freq_to,1);
xsamp_hz=linspace(samp_range_hz(1),samp_range_hz(2),1e3);

%i want to convert this delta freq back to detla meters
% delta_\lambda=\lambda-\lambd_TO= c/v - c/v_to
% = c( v_to/(v�v_to)  - v/(v�v_to )
% = c (v_to-v)/(v�v_to) 
% delta_v = v -v_TO
% = -c (delta_v)/(v�v_to) 
% = -c (delta_v)/((delta_v + v_TO)� v_to) 
% = -c (delta_v)/(delta_v�v_to + v_TO^2) 

diff_freq_to_m=@(delta_f) -const.c*delta_f./(delta_f*freq_to + freq_to^2);
%is this level of rigour actually needed
frac_diff(diff_freq_to_m(1e9),1e9*dn_lambda_over_domega_n(freq_to,1))
% simple first derivative treatment gives ppm error at 1ghz

plot_x_factor_freq=1e-9;
polz_full_freq=taylor_series(xsamp_hz,dyn_polz_deriv_freq.vals,0);
polz_first_freq=taylor_series(xsamp_hz,dyn_polz_deriv_freq.vals(1:2),0);
frac_diff_series=@(x) abs((taylor_series(x,dyn_polz_deriv_freq.vals,0)-taylor_series(x,dyn_polz_deriv_freq.vals(1:2),0))./taylor_series(x,dyn_polz_deriv_freq.vals,0));


xsamp_hz_to_m=diff_freq_to_m(xsamp_hz);
stfig('first order comparison')
subplot(2,1,1)
hold on
plot(plot_x_factor*xsamp_hz_to_m,polz_full_freq)
plot(plot_x_factor*xsamp_hz_to_m,polz_first_freq)
hold off
subplot(2,1,2)
hold on
plot(plot_x_factor*xsamp_hz_to_m,abs((polz_first_freq-polz_full_freq)./polz_full_freq))
plot(plot_x_factor*xsamp_hz_to_m,frac_diff_series(xsamp_hz))
hold off


stfig('first order comparison freq')
clf
subplot(2,1,1)
plot(plot_x_factor_freq*xsamp_hz,polz_full_freq)
hold on
plot(plot_x_factor_freq*xsamp_hz,polz_first_freq)
xlabel('detuning from TO(GHz)')
hold off
subplot(2,1,2)
plot(plot_x_factor_freq*xsamp_hz,abs((polz_first_freq-polz_full_freq)./polz_full_freq))
ylabel('fractional difference')
xlabel('detuning from TO(GHz)')
hold on
plot(plot_x_factor_freq*xsamp_hz,abs(frac_diff_series(xsamp_hz)-0.1))
hold off


%%

fminsearch(@(x) abs(frac_diff_series(x*1e9)-0.1),0.1)
fminsearch(@(x) abs(frac_diff_series(x*1e9)-0.1),-0.1)

%%

fprintf('%g\n',dyn_polz_deriv_freq.vals)
fprintf('si \n')
fprintf('%g\n',dyn_polz_deriv_freq.vals*4*pi*const.epsilon0*const.a0^3)

