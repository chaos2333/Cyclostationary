function [DC_bias]=finite_window_DC_bias(Lxx,a_min,f_min)
 laa=0;
for La=[200 ];%200%
         laa=laa+1;
    kk=0;
    for f=0:f_min:1 
         kk=kk+1;
         maen_P=0;
         aa=0;
         for a=-0.5:a_min:0.5
             aa=aa+1;
             if abs(a)<0.00001  % abs(a-1/rso)<0.00001 || abs(a+1/rso)<0.00001%
                 if  abs(f-a)<0.00000001   ||  abs(abs(f-a)-1)<0.00000001
                   zerkk=1/La*Lxx(aa).*(La.^2);
                   maen_P= maen_P+ zerkk;
                 else
                   zerkk=1/La*(Lxx(aa).*((sin(pi*La*(f-a))/sin(pi*(f-a))).^2));
                   maen_P= maen_P+ zerkk; 
                 end
             else     
             end

         end
        perdri(laa,kk)= maen_P;
    end
end
DC_bias=abs(perdri);
 save('offset_perdri_20W_zeropeak.mat','DC_bias');
