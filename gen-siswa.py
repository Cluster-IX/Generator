#!/bin/env python

import csv
from faker import Faker

max_siswa = 500 * 1000
# max_siswa = 100
max_kota = 38
max_mapel = 7


def main():
    fake = Faker()

    file = open("./csv/siswa.csv", "w")
    writer = csv.writer(file)

    current_kota = 1
    current_urutan = 1
    batch_data = []
    for current_siswa in range(max_siswa):
        if current_urutan > (max_siswa / max_kota):
            current_urutan = 0
            current_kota += 1

        current_urutan += 1
        nrp = format_nrp(current_kota, current_urutan)
        nama = fake.name()
        batch_data.append([nrp, nama])
        if current_siswa % 100 == 0:
            writer.writerows(batch_data)
            batch_data = []


def format_nrp(nrp_prefix, nrp_suffix):
    nrp_prefix = nrp_prefix if nrp_prefix > 10 else f"0{nrp_prefix}"
    return f"{nrp_prefix}{nrp_suffix:0{12}}"


if __name__ == "__main__":
    main()
