args = argv();
addpath('/content/3dpose')
printf("args = %s\n", args{1});
demoold(args{1}, args{2});
printf("this is the end\n");