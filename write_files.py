import uuid

if __name__ == "__main__":
    for i in range(5000):
        data = str(uuid.uuid4())
        with open(f"/mnt/cephfs/{i}.txt", "w") as f:
            f.write(data)
