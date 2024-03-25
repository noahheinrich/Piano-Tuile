class SpriteAnim {
  int index;
  int compt;
  int vit;
  int nbImg;
  PImage img;
  PImage[] tabImg;
  SpriteAnim(String nomImg,int nbImage, int vitAnim){
    index=0;
    compt=0;
    vit=vitAnim;
    nbImg=nbImage;
    img=loadImage(nomImg);
    tabImg=new PImage[nbImage];
    for (int i=0;i<nbImg;i++){
      tabImg[i]=img.get(100*i,0,100,100);
    }
  }
  void anim(int x, int y){
    if (compt==vit){
      compt=0;
      index=index+1;
      if (index==nbImg){
        index=0;
      }
    }
    compt=compt+1;
    image(tabImg[index],x,y);
  }
}
