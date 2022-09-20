#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include<string.h>
#include<sys/types.h>
#include<sys/mman.h>
#include<fcntl.h>

#define FRAME_WIDTH 640
#define FRAME_HEIGHT 480
#define FRAME_BUFFER_DEVICE  "/dev/fb0"

int main(){
    int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];
    int max_cX = -700;
    int min_cY = 270;
    int cY_step = -5;
    int cX = -700;
    int cY;
    int fd;

    extern char teamname[];
    extern char s1[];
    extern char s2[];
    extern char s3[];
    extern int num1;
    extern int num2;
    extern int num3;
    extern int sum;
    extern void name();
    extern void id();
    extern void drawJuliaSet(int a, int b,int c,int d, int16_t frame[FRAME_HEIGHT][FRAME_WIDTH]);
    printf("Function1: Name\n");
    name();
    printf("Function1: ID\n");
    id();
    printf("\nMain_Function:\n");
    printf("*****Print_All*****\n");
    printf("%s",teamname);
    printf("%d  %s",num1,s1);
    printf("%d  %s",num2,s2);
    printf("%d  %s",num3,s3);
    printf("ID Summation = %d\n", sum);
    printf("*****End_Print*****\n");
    printf("\n***** Please enter p to draw Julia Set animation *****\n");
    while(getchar()!='p'){}
    system("clear");
    fd = open( FRAME_BUFFER_DEVICE,(O_RDWR | O_SYNC ));
    if(fd<0) printf("Frame Buffer Device Open Error!!\n");
    else{
        for( cY=400; cY>=min_cY;cY=cY+cY_step){
            drawJuliaSet(cX,cY,FRAME_WIDTH,FRAME_HEIGHT,frame);
            write(fd,frame,sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH);
            lseek(fd,0,SEEK_SET);
        }//for
        printf(".*.*.*.<:: Happy New Year ::>.*.*.*.\n");
        printf("by %s", teamname);
        printf("%d  %s",num1,s1);
        printf("%d  %s",num2,s2);
        printf("%d  %s",num3,s3);
        close(fd);
    }//else

    while(getchar()!='p'){}

    return 0;
}


