FROM sebvaucher/sgx-base:sgx_2.5

COPY . ./
RUN make SGX_MODE=SIM

CMD ["./app"]