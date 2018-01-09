# NVIDIA GPU Telemetry Exporter for Prometheus

## Requirements

* CUDA 8.X - Modifications may need to be made in nvml.go to point to your install

## Building

    $ CGO_LDFLAGS="</usr/lib/nvidia-<driver_version>" go build -o nvidia_exporter

## Usage

  - By binary

        $ ./nvidia_exporter [flags]`

  - By Docker

        $ docker build -t nvidia-exporter:v1.0.2
        $ docker run --rm -v /var/lib/nvidia-docker/volumes/nvidia_driver/current/lib64:/usr/local/nvidia/lib64 --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidia1:/dev/nvidia1 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm nvidia-exporter:v1.0.2

  - By kubernetes

        $ #Please prepare the docker image
        $ #And update the nvidia-exporter-ds.yaml according to your environment
        $ cd kubernetes
        $ kubectl apply -f nvidia-exporter-ds.yaml
        $ kubectl apply -f nvidia-exporter-svc.yaml

### Flags

* __`web.listen-address`:__ Listen on this address for requests (default: `":9114"`).
* __`web.telemetry-path`:__ Path under which to expose metrics (default: `"/metrics"`).

## License

Portions of nvml.go are based on David Ressman [go-nvml](https://github.com/davidr/go-nvml). It has been cleaned up and modified for this exporter.

MIT
