import uuid

if __name__ == "__main__":
    for i in range(1000):
        filename = str(uuid.uuid4())
        with open(f"/mnt/cephfs/{filename}.txt", "w") as f:
            f.write(filename)
