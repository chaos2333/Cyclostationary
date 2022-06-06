load('Antenna1.mat')
odata_noise_o=real(signal_1);
pdata_noise_o=imag(signal_1);
Power_a=(odata_noise_o.^2+pdata_noise_o.^2);     %/max(2*odata_noise_o.^2)
tic
tao_max=100000;
for tao=-tao_max:1:tao_max
    zixiangguan=0;
   for t=100011:300010
      zixiangguan=zixiangguan+conj(Power_a(t)).*Power_a(t+tao);
   end
   aver(tao+tao_max+1)=zixiangguan/200000;
end
kk=0;
a_min=1/200000;
for a=-1/2:a_min:1/2  
        kk=kk+1;
        Lxx_a=0;
    for tao=-tao_max:1:tao_max
         Lxx_a=Lxx_a+aver(tao+tao_max+1).*exp(-1j*2*pi*a*(tao));
    end
        Lxx(kk)=Lxx_a;
end
toc
f_min=1/200000;
[cycli_spectrum]=resultant_cycli_spectrum(Lxx,a_min,f_min);
[DC_bias]=finite_window_DC_bias(Lxx,a_min,f_min);
[non_DC_bias]=finite_window_non_DC_bias(Lxx,a_min,f_min);
[OSR_peak]=the_convolution_of_the_OSR_peak(Lxx,a_min,f_min);
figure 
plot(0:f_min:1, cycli_spectrum,'-k','linewidth',1.3)  
hold on
plot(0:f_min:1,OSR_peak,'-r','linewidth',1.3)
hold on
plot(0:f_min:1, non_DC_bias,'-g','linewidth',1.3)
hold on
plot(0:f_min:1, DC_bias,'-b','linewidth',1.3)
hold on
legend( '$\hat P(f)$ obtained by Eq. (11)', '${\hat P}_{\varepsilon}(f)$ in Eq. (11)','${\hat P}_{{dc}}(f)$ in Eq. (6)','${\hat P}_{{{ndc}}}(f)$ in Eq. (6)','interpreter','latex'); 
 xlabel('Normalized Frequency','fontsize',12);
               ylabel('Spectrum','fontsize',12);
               set(gca,'FontSize',12);
           xlim([0 0.5]);
          ylim([0 400000000000]);