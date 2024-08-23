import os


directory_path = 'train2017'
output_file = 'output.txt'
file_names = os.listdir(directory_path)

if __name__ == '__main__':
    
    with open("output.txt", "w") as f:
        for file_name in file_names:
            if os.path.isfile(os.path.join(directory_path, file_name)):
                f.write(file_name.strip(".png") + '\n')
    print(f'File names have been written to {output_file}')