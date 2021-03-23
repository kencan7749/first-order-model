#!/usr/bin/bash

# Get github log


file_name_path=(`ls /home/shirakawa/movie/data/contents_shared/MITtest_v1/source`)

driving_image_path="/home/shirakawa/movie/code/py3_bdata_analysis/python/feature-inversion/results/recon_decoded_feature/recon_img_from_MIT_decoded_feature_pytorch_DGN_various_model_optimizer_grad_norm/pytorch/VGG_ILSVRC_19_layers/KS_short_ave_tr2/VC_retiMTDVC/Adam/"
driving_video_path="/home/shirakawa/movie/code/py3_bdata_analysis/python/feature-inversion/results/recon_decoded_feature/recon_short_vid_from_MotionNet_VGG_combine_feature_pytorch_equal_corrloss_static_input_gblur_201207/KS_short_ave_tr2/VC_retiMTDVC/Adam/"
# check for loop

save_dir="Recon_vid_from_recon_img_and_recon_video/"
mkdir $save_dir

for N in {1..50}; do
    image_file_name="recon_DGN_grad_normn"
    suffix="_0.jpg"
    #s=`prinf %08d $N`
    image_path=$driving_image_path${image_file_name}$(printf "%08d" ${N})${suffix}
    echo $image_path
    if [ ! -e $image_path ]; then
        echo "File doesn't exitst"
    fi
    video_dir_name="n"
    video_suffix="_0/no_correct/0.5/recon.avi"
    video_path=$driving_video_path${video_dir_name}$(printf "%08d" ${N})${video_suffix}
    echo $video_path
    
    res_name=$(printf "%02d" ${N})
    res_file=$save_dir$res_name".mp4"
    python demo.py --config "config/taichi-256.yaml" --driving_video ${video_path} --source_image ${image_path} --checkpoint "checkpoints/taichi-cpk.pth.tar" --result_video ${res_file}
done

