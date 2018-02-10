//Syphon
import codeanticode.syphon.*;
SyphonServer server;

//Minim（フーリエ変換）
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;

//オーディオ
AudioInput in;

//FFTの変数
FFT fft;

int i_1 = 0;
int i_2 = 0;
int i_3 = 0;
int i_4 = 0;

final int OBJ_NUM = 10000; //落ちてくる四角の最大数
float[] y_1 = new float[OBJ_NUM];
float[] y_2 = new float[OBJ_NUM];
float[] y_3 = new float[OBJ_NUM];
float[] y_4 = new float[OBJ_NUM];

void setup() {
  size(960, 540, P3D);
  PJOGL.profile = 1;
  server = new SyphonServer(this, "Processing Syphon");
  
  frameRate(6);
  
  //Minim初期化
  minim = new Minim(this);
  
  //ステレオオーディオ入力を取得
  in = minim.getLineIn(Minim.STEREO, 512);
  
  //ステレオオーディオ入力をFFTと関連づけ
  fft = new FFT(in.bufferSize(), in.sampleRate());
  
  for (int j = 0; j < OBJ_NUM; j++) {
    y_1[j] = 0;
    y_2[j] = 0;
    y_3[j] = 0;
    y_4[j] = 0;
  }
}

void draw() {
  
  //背景を黒に設定
  background(0);
  
  stroke(255, 0, 0);
  strokeWeight(2);
  line(0, height/8*7, width, height/8*7);
  
  //線の色を白に設定
  stroke(255);
  strokeWeight(1);
  
  //FFT実行 左右の入力音をmixしてFFT
  fft.forward(in.mix);
  //FFTのスペクトラム(分解された音の周波数幅)の幅を変数に保管（視覚化）
  int specSize = fft.specSize();
  
  //棒グラフを描画
  for (int i = 0; i < specSize; i++) {
    //xをスペクトラムの幅に応じた位置として取得 iを0〜specsize→0~widthに変換
    float x = map(i, 0, specSize, 0, width);
    //fft.getBand(i)で個別のスペクトラムの値を取得し、取得した値に応じた線を描く
    //fft.getBandf(i)で音量を取得
    //line(x, height, x, height - fft.getBand(i) * 8);
    line(x, height/2, x, height/2 - fft.getBand(i) * 16);
    line(x, height/2, x, height/2 + fft.getBand(i) * 16);
  }
  
  //周波数を0〜256で4分割、それぞれの値で四角落としたり円を描いたり
  
  //その場の音量によって変えるべき数値
  float getBandVal = 1.0; // 普通は5.0？
  
  //0~64 
  int spec_1 = specSize/8;
  
  //四角落とす
  if (fft.getBand(spec_1) * 8 > getBandVal) {
    fill(247, 7, 211);
    rect(width/16, y_1[i_1], width/8, height/8);
    y_1[i_1] = height/8;
    i_1 += 1;
  }
  if (i_1 > 0) {
    if (y_1[i_1-1] > 0) {
      for (int k = 0; k < i_1; k++) {
        fill(247, 7, 211);
        rect(width/16, y_1[k], width/8, height/8);
        y_1[k] += height/8;
      }
    }
  }
  
  
  
  
  //64~128
  int spec_2 = specSize/8*3;
  
  if (fft.getBand(spec_2) * 8 > getBandVal/8) {
    fill(39, 249, 242);
    rect(width/16*5, y_2[i_2], width/8, height/8);
    y_2[i_2] = height/8;
    i_2 += 1;
  }
  if (i_2 > 0) {
    if (y_2[i_2-1] > 0) {
      for (int k = 0; k < i_2; k++) {
        fill(39, 249, 242);
        rect(width/16*5, y_2[k], width/8, height/8);
        y_2[k] += height/8;
      }
    }
  }
  
  //128~192
  int spec_3 = specSize/8*5;
  
  if (fft.getBand(spec_3) * 8 > getBandVal/10) {
    fill(250, 255, 2);
    rect(width/16*9, y_3[i_3], width/8, height/8);
    y_3[i_3] = height/8;
    i_3 += 1;
  }
  if (i_3 > 0) {
    if (y_3[i_3-1] > 0) {
      for (int k = 0; k < i_3; k++) {
        fill(250, 255, 2);
        rect(width/16*9, y_3[k], width/8, height/8);
        y_3[k] += height/8;
      }
    }
  }
  
  //192~256
  int spec_4 = specSize/8*7;
  
  if (fft.getBand(spec_4) * 8 > getBandVal/15) {
    fill(1, 255, 48);
    rect(width/16*13, y_4[i_4], width/8, height/8);
    y_4[i_4] = height/8;
    i_4 += 1;
  }
  if (i_4 > 0) {
    if (y_4[i_4-1] > 0) {
      for (int k = 0; k < i_4; k++) {
        fill(1, 255, 48);
        rect(width/16*13, y_4[k], width/8, height/8);
        y_4[k] += height/8;
      }
    }
  }
  
  println(specSize);
  println(fft.getBand(spec_1));
  println(fft.getBand(spec_2));
  println(fft.getBand(spec_3));
  println(fft.getBand(spec_4));
  
  //SyphonServerに送る
  server.sendScreen();
}

void stop() {
  minim.stop();
  super.stop();
}