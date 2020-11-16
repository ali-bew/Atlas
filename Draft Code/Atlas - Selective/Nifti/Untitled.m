trtr = load_untouch_nii('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Training_Set\IBSR_07\IBSR_07.nii');
immm = trtr.img;
immm = immm==0;
immm = 1 - immm;
trtr.img = immm;
save_untouch_nii(trtr,'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Training_Set\IBSR_07\IBSR_07kk.nii')