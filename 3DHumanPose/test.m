function tt(a,b)
x = strcat(a,".txt");
display(class(a));
display(a);
display(b);
csvwrite(x, a);
end