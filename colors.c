#include <stdio.h>
int main(int argc, char *argv[])
{
        long int N,K;
        long int count =0; 
	long int length = 0;
	long int min_len = 1000001;
	long int start=0;
	long int end=0;
	long int i;


    FILE *myFile;
    myFile = fopen(argv[1], "r");
    fscanf(myFile, "%ld", &N);
	fscanf(myFile, "%ld\n", &K);

    //read file into array
    long int kordela[1000000];
    long int colors[10000];
 

    for (i = 0; i < N; i++)
    {
        fscanf(myFile, "%ld", &kordela[i]);
         
    }
    

  
   for(i=0; i<K; i++)
	{
		colors[i] = 0; //arxikopoiisi tou pinaka xrwmatwn
	}

	for(i=0; i<N; i++)
	{
		if(colors[kordela[i]-1]==0)
		{
			end++;
			count++;
			colors[kordela[i]-1]++;
			
		}
		else
		{
			end++;
			colors[kordela[i]-1]++;
		}
		while ((colors[kordela[start]-1]>1) )
		{
		   colors[kordela[start]-1]-- ;
		   start++;
		    
		}
		
		
		if(count == K)
		{
			length= (end-start);
			if(length<min_len) 
			{
				min_len=length;
		        }
		}
	}
        
	if(count==K)
	{
		printf("%ld\n", min_len);
		
	}
	else
	{
		min_len=0;
		printf("%ld\n", min_len);
	}

	return 0;
} 



