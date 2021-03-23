#!/usr/bin/bash

# Get github log


file_name_path=(`ls /home/shirakawa/movie/data/contents_shared/MITtest_v1/source`)
file_image_path=(`ls /home/shirakawa/movie/data/contents_shared/MITtest_v1/derivatives/frames/f0t90_224x224`)

driving_image_path="/home/shirakawa/movie/data/contents_shared/MITtest_v1/derivatives/frames/f0t90_224x224/"


driving_video_path="/home/shirakawa/movie/data/contents_shared/MITtest_v1/source/"
# check for loop

save_dir="Recon_vid_from_true_img_and_true_video/"
mkdir $save_dir

for N in {1..50}; do
    

    video_path=$driving_video_path${file_name_path[N-1]}
    echo $video_path
    
    suffix="/image_0000.jpg"
    #s=`prinf %08d $N`
    image_path=$driving_image_path${file_image_path[N-1]}${suffix}
    echo $image_path
    if [ ! -e $image_path ]; then
        echo "File doesn't exitst"
    fi
    
    res_name=$(printf "%02d" ${N})
    
    res_dir=$save_dir"/taichi-256/"
    mkdir $res_dir
    res_file=$res_dir$res_name".mp4"
    python demo.py --config "config/taichi-256.yaml" --driving_video ${video_path} --source_image ${image_path} --checkpoint "checkpoints/taichi-cpk.pth.tar" --result_video ${res_file}
    
    res_dir=$save_dir"/bair-256/"
    mkdir $res_dir
    res_file=$res_dir$res_name".mp4"
    python demo.py --config "config/bair-256.yaml" --driving_video ${video_path} --source_image ${image_path} --checkpoint "checkpoints/bair-cpk.pth.tar" --result_video ${res_file}
    
    res_dir=$save_dir"/fashion-256/"
    mkdir $res_dir
    res_file=$res_dir$res_name".mp4"
    python demo.py --config "config/fashion-256.yaml" --driving_video ${video_path} --source_image ${image_path} --checkpoint "checkpoints/fashion.pth.tar" --result_video ${res_file}
    
    res_dir=$save_dir"/mgif-256/"
    mkdir $res_dir
    res_file=$res_dir$res_name".mp4"
    python demo.py --config "config/mgif-256.yaml" --driving_video ${video_path} --source_image ${image_path} --checkpoint "checkpoints/mgif-cpk.pth.tar" --result_video ${res_file}
    
    res_dir=$save_dir"/vox-adv-256/"
    mkdir $res_dir
    res_file=$res_dir$res_name".mp4"
    python demo.py --config "config/vox-adv-256.yaml" --driving_video ${video_path} --source_image ${image_path} --checkpoint "checkpoints/vox-adv-cpk.pth.tar" --result_video ${res_file}
    
     res_dir=$save_dir"/vox-256/"
    mkdir $res_dir
    res_file=$res_dir$res_name".mp4"
    python demo.py --config "config/fashion-256.yaml" --driving_video ${video_path} --source_image ${image_path} --checkpoint "checkpoints/vox-cpk.pth.tar" --result_video ${res_file}
done

