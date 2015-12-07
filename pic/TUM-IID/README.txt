Introduction
The availability of digital photography has increased in recent years. Nowadays most mobile phones are equipped with cameras. Naturally, the interest in image manipulation tools has been growing. A common demand is the removal of interfering objects or persons from an image. Obviously, this leaves holes in the image which need to be filled. This task is called image inpainting. 
When presenting a new inpainting algorithm the authors show usually side by side comparisons between their inpainted images and results of existing algorithms. The problem is that no database of images 
with including baseline images exists. Only with a common database wider comparison and statements can be made.

Database Description and Contribution
We provide a database consisting of 17 base images. These images differ in relation to texture and structure diversity. Each of these images is inpainted by four state-of-the-art inpainting algorithms [1-4]. We use two compact and two spread-out target regions, which define the inpainting area. The compact region is a blob-like area, whereas the spread-out region consists of thinner lines distributed over a wider space in the image. The occupied size, however, is in both cases 5% for the small and 10% for the big-sized target region. In total 273 inpainted images are available which allow comprehensive comparison between new and existing algorithms. The template of the target regions is available too. 

[1] Aurélie Bugeau, Marcelo Bertalm´ io, Vicent Caselles, and Guillermo Sapiro, “A comprehensive framework for image inpainting,” IEEE Transactions on Image Processing, vol. 19,no. 10, pp. 2634–2645, 2010.
[2] Jan Herling and Wolfgang Broll, “Pixmix: A real-time approach to high-quality diminished reality,” in International Symposium on Mixed and Augmented Reality. 2012, pp. 141–150, IEEE
[3] Pascal Getreuer, “Total variation inpainting using split bregman,” Image Processing On Line, vol. 2, pp. 147–157, 2012.
[4] Zongben Xu and Jian Sun, “Image inpainting by patch propagation using patch sparsity,” IEEE Transactions on Image Processing, vol. 19, no. 5, pp. 1153–1165, 2010




Acknoelwedgmenet
If you use this database in your research, please cite the following paper:  
Philipp Tiefenbacher, Viktor Bogischef, Daniel Merget and Gerhard Rigoll, “Subjective and Objective Evaluation of Image Inpainting Quality,” to appear

Download
The database is provided as one compressed zip file.

	Folder Structure
		Three folders exists inside the zip-file. The "images" folder includes all base images. The "inpaintedImages" folder holds all inpainted images. The names of those images are following the naming scheme beloew. The last folder "masks" includes the four masks in "png" and "svg" file format.
	File Format
		The inpainted images files are named "algorithm-ImageNr-TargetRegionN.png", where algorithm is one of the four author names, ImageNr is a number between 1-17 referring to the base images (see folder "images"). TargetRegionNr defines the kind of applied target region (see folder "masks").

Contact and Links
Philipp Tiefenbacher (philipp.tiefenbacher(AT)tum.de) (replace (AT) with @)
Chair for Human-Machine Communication, Technische Universität München