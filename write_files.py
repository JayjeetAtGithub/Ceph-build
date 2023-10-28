import uuid

if __name__ == "__main__":
    for i in range(100000):
        data = str(uuid.uuid4())
        with open(f"/mnt/cephfs/{data}.txt", "w") as f:
            f.write(data)
