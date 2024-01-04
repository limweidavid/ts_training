
def main():
    print_header()
    for line in f.readlines():
        col = line.rstrip().split(',')
        print_reg(col[1],col[2],col[3])
    print_footer()

def print_header():
    fo.write('<?xml version="1.0" encoding="UTF-8"?>'+"\n")
    fo.write('<spirit:component xmlns:spirit>'+"\n")
    fo.write('\t<spirit:library>TS_TRAINING</spirit:library>\n')
    fo.write('\t<spirit:version>1.0</spirit:version>'+"\n")

def print_footer():
    fo.write('</spirit:component>\n')

def print_reg(name,size,access):
    fo.write('\t\t<spirit:register>\n')
    fo.write('\t\t\t<spirit:name>{}</spirit:name>\n'.format(name))
    fo.write('\t\t\t<spirit:size>{}</spirit:size>\n'.format(size))
    if access == 'rw':
        fo.write('\t\t\t<spirit:access>read-write</spirit:access>\n')
    elif access == 'ro':
        fo.write('\t\t\t<spirit:access>read-only</spirit:access>\n')
    fo.write('\t\t</spirit:register>\n')

if __name__ == '__main__':
    f = open('regfile.csv','r')
    fo = open('ipxact.xml','w')

    main()
