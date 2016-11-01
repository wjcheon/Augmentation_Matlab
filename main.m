%%
%  Dicom -> ROI cropping -> Augmentation (flip(l,r,u,d),rotate(+,-45
%  degree) -> PNG
%
%  1 image will be 8 image
%


clc
clear
close all

%% SET PARAMETERS



%%
% Select the folder containning dicom files
folder_dir = uigetdir('Select a folder!');
folders = dir(fullfile(folder_dir));
addpath(folder_dir);

folders(1:2,:) = [];

Label_Png = {'Augmentation'}

for iter3 = 1:size(Label_Png,2)
    New_folder_name_png = [folder_dir '\' Label_Png{1,iter3}];
    mkdir(New_folder_name_png);
end

%%

for iter1 = 1:size(folders,1)
        DicomImgName = [folder_dir '\' folders(iter1).name];
        DicomImg = dicomread(DicomImgName);
        DicomImg_gray = rgb2gray(DicomImg);
        DicomImg_gray_boolian = DicomImg_gray<50;
        circles = houghcircles(DicomImg_gray_boolian, 1600, 1650);
end


%%

waitbar_maxsz = (size(folders,1));
h = waitbar(0,'Please wait...');
for iter1 = 1:size(folders,1)
    if ~folders(iter1).isdir
        a=0;
        DicomImgName = [folder_dir '\' folders(iter1).name];
        DicomImg = dicomread(DicomImgName);
        DicomImg_gray = rgb2gray(DicomImg);
        DicomImg_gray_boolian = DicomImg_gray<50;
        figure, imshow(ans)
        
         circles = houghcircles(DicomImg_gray_boolian, 1600, 1650)
        [centers, radii, metric]  = imfindcircles(DicomImg_gray_boolian,[1600 1650]);
        figure, imshow(DicomImg_gray_boolian)
        
        
        
        
        PngTarget_dir = [labeled_folder_dir '_png'];
        Pngfile_name = [folders(iter1).name(1:end-4) '.png'];
        imwrite(imresize(DicomImg,CompressionRatio),fullfile(PngTarget_dir,Pngfile_name),'png');
        
    end
    disp(iter1)
    waitbar(iter1/waitbar_maxsz)
end
close(h)
































