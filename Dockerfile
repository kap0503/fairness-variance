FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-runtime

# # Set the working directory in the container
WORKDIR /app

RUN pip3 install torch torchvision torchaudio
RUN pip3 install numpy
RUN pip3 install scikit-learn
RUN pip3 install matplotlib pandas tensorboardX h5py

CMD ["/bin/bash"]