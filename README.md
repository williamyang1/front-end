Test configurations:
cuda11.8 + 8.6.0.163
cuda11.7 + 8.5.0.96
cuda11.6 + 8.4.0.27
cuda11.5 + 8.3.0.40
cuda11.4 + 8.2.4.15
cuda11.2 + 8.1.1.3
cuda11.8 + 8.7.0.64
cuda12.0 + 8.8.0.34

Prepare test resource.
1. Download cmake-3.24 and extrack
2. Download cuda12 and cudnn_8.8.0.* and cudnn_8.7.0.* for local installer to download folder.
3. Git cudnn front-end source code https://confluence.nvidia.com/pages/viewpage.action?spaceKey=GCA&title=cuDNN+Frontend+Release+-+QA+checklist
4. Installer Docker and Download Docker images by docker_download.sh

Test Steps:
1. Download Docker images by docker_download.sh
2. Update cudnn version in run_test_87.sh and run_test_88.sh
3. Run cudnn front-end test by test_full.sh
