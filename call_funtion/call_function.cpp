
int my_global_var = 10;

extern "C" void my_func()
{
    int abc = 0;

    my_global_var = 1;
 
}

extern "C" int add(int a, int b)
{
     return a+b;
}

extern "C" int diff(int a, int b)
{
    return a-b;
}

extern "C" int prod(int a,int b)
{
    return a*b;
}
