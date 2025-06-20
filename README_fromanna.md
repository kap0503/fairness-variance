# Important directories/general pointers

Original repo for reference ----- https://github.com/lin-tan/fairness-variance/tree/master/dlfairness 
Folder original_code has all the code to be run
- I have run only exps. in DomainBiasMitigation folder for which I have a Docker image from which I built a Apptainer image; this may or may not work for the other experiments. (more details in the next section). For other experiments look at dlfairness/fairness_test_config.json and MD files in the dlfairness/docs to figure out what scripts you need to run. I can help with Docker images, dependencies etc. if you need it for other settings. 
- I have my Apptainer image and other scripts in my experiment folder; should you choose to run it in the root folder (fairness-variance/), you will have to change those accordingly. 
- Example job submission script (Example_job.sub) has some example instructions on running training, testing, gathering metrics with the assumption that the Apptainer image is in DomainBiasMitigation. For other experiments, refer the dlfairness/docs
- For the datasets in DomainBiasMitigation run download.sh and run preprocess_data soon after; for the others, each experiment folder has a README you can refer, I find the docs to be very helpful. 
- To change the # of epochs for DomainBiasMitigation, the file to be changed is parse_args.py. 

# Dockerfiles, Docker images, Apptainer

I have provided a Dockerfile I used for DomainBiasMitigation. For the other experiments, you will have to look at the requirements and adjust the file accordingly; note that sometimes the code won't work due to differing PyTorch versions etc. In such a case, I would suggest using Conda in your Dockerfile and using a CUDA-enabled Conda image for the same. Follow these steps to build an Apptainer image on your local machine;

-- First install apptainer https://apptainer.org/docs/admin/main/installation.html#install-from-pre-built-packages 

-- Install Docker, create a DockerHub account if need be

-- Build Docker image from Dockerfile and push to DockerHub-- 
```
docker build . <dockerhubusername>/<name-of-image>
docker image push <name-of-image>:latest
```
-- Build apptainer image from Docker image:

```
sudo apptainer build <name-of-apptainer-image>.sif docker://<dockerhub-user>/<name-of-image>:latest
```

You will have a .sif file from this on your local computer; you can simply upload this to Gilbreth via the gateway. 


# Running Gilbreth jobs
```
sbatch -t <days-hours:mins:secs> --mem=<memoryG> --nodes=1 --gpus-per-node=1 -A <queue> --constraint <GPU-name> Example_job.sub
```
We currently have access to 3 queues, standby, debug and our lab queue, zghodsi-b. zghodsi-b has 14 days of walltime for each job; the GPU is an A30. The standby queues have access to A30, A100, V100 but the walltime is only 4 hours; a max. of 16 concurrent jobs can be run at a single time. Debug queue has a short walltime of 30mins for quickly debugging things.  
