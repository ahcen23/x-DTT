clear

% Copyright(c) 2023 Ahcen ALIOUAT
% All Rights Reserved.
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
% ----------------------------------------------------------------------

%% Testing DTT , IDTT and DCT for x-DTT package published in SoftwareX Journal (Elsevier)

%% read Input Image
A = imread('L:\DTT vs DCT\dataset2\boat512.tiff');

%% Reserve variables memory
QF=[];
PSNR_dtt=[];
SSIM_dtt=[];
BPP_dtt= [];
SM_SIM_dtt=[];

PSNR_dct=[];
SSIM_dct=[];
BPP_dct= [];
SM_SIM_dct=[];

PSNR_idtt=[];
SSIM_idtt=[];
BPP_idtt= [];
SM_SIM_idtt=[];

mape_dct=[];
mape_dtt=[];
mape_idtt=[];

%% 
%% Mean for Matrix
meanmat=@(a)(mean(mean(a)));
%%

for qf=1:1:25

%% code with I-DTT

[bitsPerPixel_idtt,bpp_idtt,SizeCoded_idtt, jpeg_idtt_decoded]=jpegIDTT(A, qf);


%% Code with DTT

[bitsPerPixel_dtt,bpp_dtt,SizeCoded_dtt, jpeg_dtt_decoded]=jpegDTT(A, qf);
%figure, imshow(uint8(jpeg_dtt_decoded))
%% 
[bitsPerPixel_dct,bpp,SizeCoded, jpeg_decoded]=jpeg(A, qf);
%figure, imshow(uint8(jpeg_decoded))

%% PSNR
p1=psnr(uint8(jpeg_dtt_decoded),uint8(A),255);
p2=psnr(uint8(jpeg_decoded),uint8(A),255);
p3=psnr(uint8(jpeg_idtt_decoded),uint8(A),255);

%% SSIM
s1=ssim(uint8(A),uint8(jpeg_dtt_decoded));
s2=ssim(uint8(A),uint8(jpeg_decoded));
s3=ssim(uint8(A),uint8(jpeg_idtt_decoded));
%% SM-SIM
%% SR-SIM
ss1=SR_SIM(uint8(A),uint8(jpeg_dtt_decoded));
ss2=SR_SIM(uint8(A),uint8(jpeg_decoded));
ss3=SR_SIM(uint8(A),uint8(jpeg_idtt_decoded));

%% IDTT: QF vs PSNR vs SSIM vs BPP 
QF=  [QF qf];
PSNR_idtt=[PSNR_idtt p3];
SSIM_idtt=[SSIM_idtt s3];
SM_SIM_idtt=[SM_SIM_idtt ss3];

BPP_idtt= [BPP_idtt bitsPerPixel_idtt];

%% DTT: QF vs PSNR vs SSIM vs BPP 
QF=  [QF qf];
PSNR_dtt=[PSNR_dtt p1];
SSIM_dtt=[SSIM_dtt s1];
BPP_dtt= [BPP_dtt bitsPerPixel_dtt];
SM_SIM_dtt=[SM_SIM_dtt ss1];


%% DCT: QF vs PSNR vs SSIM vs BPP 

PSNR_dct=[PSNR_dct p2];
SSIM_dct=[SSIM_dct s2];
SM_SIM_dct=[SM_SIM_dct ss2];
BPP_dct= [BPP_dct bitsPerPixel_dct];

%% MEAN APE
A(A==0)=1;
Res_Mape1=meanmat(abs(double(jpeg_decoded)-double(A))./double(A))*100;
Res_Mape2=meanmat(abs(jpeg_dtt_decoded-double(A))./double(A))*100;
Res_Mape3=meanmat(abs(jpeg_idtt_decoded-double(A))./double(A))*100;

mape_dct=[mape_dct Res_Mape1];
mape_dtt=[mape_dtt Res_Mape2];
mape_idtt=[mape_idtt Res_Mape3];

end

figure(1)
plot(QF,PSNR_dct)
hold on
plot(QF,PSNR_dtt)
xlabel("QF")
ylabel("PSNR")
legend('8x8 DCT', '8x8 DTT')

figure(2)
plot(QF,SSIM_dct)
hold on
plot(QF,SSIM_dtt)
xlabel("QF")
ylabel("SSIM")
legend('8x8 DCT', '8x8 DTT')


figure(3)
plot(QF,BPP_dct/8)
hold on
plot(QF,BPP_dtt/8)
xlabel("QF")
ylabel("bpp")
legend('8x8 DCT', '8x8 DTT')


figure
plot(BPP_dct(1:25),SSIM_dct(1:25))
hold on
plot(BPP_dtt(1:25),SSIM_dtt(1:25))
plot(BPP_idtt(1:25),SSIM_idtt(1:25))
xlabel("bpp")
ylabel("SSIM")
legend('8x8 DCT', '8x8 DTT','8x8 Integer DTT')

figure
plot(BPP_dct(1:25),PSNR_dct(1:25))
hold on
plot(BPP_dtt(1:25),PSNR_dtt(1:25))
plot(BPP_idtt(1:25),PSNR_idtt(1:25))
xlabel("bpp")
ylabel("PSNR")
legend('8x8 DCT', '8x8 DTT','8x8 Integer DTT')


figure
plot(BPP_dct(1:25),SM_SIM_dct(1:25))
hold on
plot(BPP_dtt(1:25),SM_SIM_dtt(1:25))
plot(BPP_idtt(1:25),SM_SIM_idtt(1:25))
xlabel("bpp")
ylabel("SM-SIM")
legend('8x8 DCT', '8x8 DTT','8x8 Integer DTT')


 figure
 plot(BPP_dct(1:25),mape_dct(1:25))
 hold on
 plot(BPP_dtt(1:25),mape_dtt(1:25))
 plot(BPP_idtt(1:25),mape_idtt(1:25))
 xlabel("bpp")
 ylabel("MAPE (%)")
 legend('8x8 DCT', '8x8 DTT','8x8 Integer DTT')
