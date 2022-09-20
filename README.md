# DrawJuliaSet

## 開發平台
Window 10

## 開發環境
QEMU Raspberry Pi Simulator

此軟體可模擬Raspberry Pi的硬體功能，並搭配Raspbian作業系統與其他需要的工具或程式開發環境，以進行ARM組合語言程式與C語言程式之組譯、編譯、與除錯。

## 說明
本project之主程式main由c語言撰寫，包含三個ARM組合語言函數name，id和DrawJuliaSet，共同構成能列印出組別、組員姓名、組員學號、組員學號加總與繪製 Julia Set 動態畫面程式，學號部分設計為可手動輸入學生學號，再將學號加總，輸出成summation，按下 p 鍵後，由 drawJuliaSet 函數與 main 函數，進行計算並完整畫出 Julia Set 動態畫面。透過 name 函數與 id 函數的回傳資料，最後印出整合組別、學號、姓名於最後一個畫面。 
專題需要掌握組合語言記憶體配置的方式、二維陣列位置的計算。 

## 使用流程
1.編譯 : gcc main.c id.s name.s drawJuliaSet.s -o out

2.執行 : ./out

## 執行方法
將此project分4成個檔案來寫，分別為name.s、id.s，DrawJuilaSet.s，main.c，在main中呼叫name、id 與DrawJuilaSet。  

## 程式說明
### name函數功能說明 :

#### 功能 :印出組別及組員姓名

#### 程式設計 : 

(a) 規劃4個記憶體區塊，分別存放組別與組員的英文姓名。

(b) 組別與組員名單已事先填入所屬之記憶體區塊。

(c) 使用( LDR = 變數)指令將各變數之記憶體區塊放入指定暫存器以便後續印出。

(d) 使用sbcals r14, r15, r13 令 r14 = r15 – r13的目的是在下一行加入add r15, r14, r13 時不會改變r15(目標暫存器)內的值。

### id函數功能說明 :

#### 功能 :印出組員學號並通過使用者輸入指令 'p' 印出學號加總值 

#### 程式設計 : 

  (a) 規劃 4 個記憶體區塊，分別存放組員組員學號以及組員學號加總值。 
  
  (b) 組員學號透過scanf讀入所屬之記憶體區塊。 
  
  (c)將讀入的指令用cmp判斷是否為'p'如果不是'p'就進入else這個function印出錯誤訊息。 
  
  (d) 將存取之組員學號記憶體的值讀入暫存器進行學號的加總。


### DrawJuilaSet函數功能說明:

#### 功能:  透過計算決定 Frame 二維陣列的長寬與陣列裡每個元素的值，以此決定回傳至main後Frame Buffer上的 Pixel 顏色。

#### 程式設計 : 

  (a) 規劃 5 個記憶體區塊，存放main 傳入之參數值。 
  
  (b) 使用 (ldr ,=參數值 str 暫存器,[暫存器]) 存取main傳入之參數值 
  
### Main函數功能說明
#### 功能: 呼叫前述name，id，DrawJuilaSet 三個函數，輸出前兩支函數的分項功能，由迴圈配合呼叫DrawJuilaSet函數輸出繪製動畫，最後使用 name與id所記錄的資料，輸出完整的組別、組員資訊與組員學號。

#### 程式設計 : 
 (a) 由C語言撰寫。 
 
 (b) 在 main中呼叫name，id與 DrawJuilaSet函數，分別達成三支函數的分項功能。
 
 (c) 應用迴圈呼叫 drawJuliaSet 函數，畫出 Julia Set 動畫。
 
 (d) 應用 name與id函數所記錄的資料，輸出完整的組別、組員資訊與組員學號數值計算結果。
 
## 程式執行結果

### JuliaSet初始畫面:
<img width="271" alt="image" src="https://user-images.githubusercontent.com/95215851/191271542-d2a3da1d-e809-4f7e-b54b-7c22187b7476.png">
### JuliaSet結束畫面:
<img width="280" alt="image" src="https://user-images.githubusercontent.com/95215851/191271643-5b42cc74-5b71-474e-8c05-7d3d44039d68.png">


