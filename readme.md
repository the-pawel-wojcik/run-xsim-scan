# xsim scripts 
Prepare, submit, pull, and plot a series of calculations that scans a
parameter in the KDC model. Support for xsim (part of CFOUR) and xsimplot.py.

For plotting, place an `xsimplot.toml` config file in the scan subdirectory.

## Usage
1. Create a directory and place there an input for xsim with an extension
`.template`.
2. git clone this this repository to that directory
```bash
git clone git@github.com:the-pawel-wojcik/run-xsim-scan
```
3. Inside the working directory, form links to the scripts located in the 
`run-xsim-scan/src` directory.
```bash
find . -name '*.sh' -exec ln '{}' ';'
```
4. Edit the `.template` file by replacing the value you would like to scan with 
`TEMPLATE_<NAME>`. Where the list of available `<NAME>` value can be checked in
`get_template_name.sh` script. Example: to scan the basis set size change a 
sample lines
```
Basis Functions
15 15 15 15 15
```
to 
```
Basis Functions
TEMPLATE_BASIS
```
5. Adjust the range of scanned parameter by editing the `run-spawn.sh` script.
6. Issue 
```bash
./run-spawn.sh
# ./color.sh # OPTIONAL, adjust the color script before you do that
./push.sh  # read this file and the trick below to get it to work
```
7. The input files are now on your cluster – submit them.
8. Once the jobs finish get the results back on your machine with
```bash
./pull.sh
```
9. View the results with
```bash
./plot.sh
```
Use the `xsimplot.py --help` to view the command line customization options or
create an `xsimplot.toml` file in the `scan` directory to keep the command line
short.

## User and domain trick in push/pull scripts
Here is how to avoid typing 
```bash
ssh user@host.domain
```

1. Set an alias in `/etc/hosts`, i.e., a line like this
```
127.0.0.1 hpc
```
You can find your server's ip with 
```bash
nslookup <host.domain>
```

2. In `~/.ssh/config` set the default user for your cluster
```
Host hpc
  User <user>
```

With these two changes you can now simply
```bash
ssh hpc
```
The same goes for `rsync`.
