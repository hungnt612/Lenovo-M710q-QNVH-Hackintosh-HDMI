# Lenovo-M710q-QNVH-Hackintosh-HDMI
OpenCore 0.7.6 compatible with macOS Monterey for Lenovo ThinkCentre M710q    
兼容 macOS Monterey 适用于“联想 ThinkCentre 系列 M710q”的欧鹏内核引导程序 0.7.6 版

![image](https://github.com/dfc643/Lenovo-M710q-QNVH-Hackintosh-HDMI/blob/main/Screenshots/about.png?raw=true)  

### System Specs / 准系统配置 :

| Component 组件   | Specifications 所用型号                | Translation 翻译                     |
| ---------------- | -------------------------------------- | ------------------------------------ | 
| CPU              | Intel® Core™ i7-8850H(ES) (QNVH)       | 英特尔 酷睿 i7-8850H 工程样片 QNVH   |
| iGPU             | Intel® UHD Graphics 630                | 英特尔 超高清图形卡 630              |
| RAM              | 2 * 8GB DDR4 2400Mhz                   | 两条 8 吉字 DDR 四代 2400 兆赫兹内存 |
| NVMe             | WD SN550 250GB                         | 西部数据 SN550 250 吉字固态硬盘      |
| LAN              | Intel I219-V                           | 英特尔 I219-V 有线网络适配器         |
| Audio            | Realtek ALC294                         | 瑞昱半导体 ALC294 集成声卡           |
| WiFi & Bluetooth | Intel(R) Dual Band Wireless-AC 3168    | 英特尔 双频无线 AC 3168 无线网卡     |
| SMBIOS           | MacMini8,1                             | 麦塔金迷你 2018 款                   |
| BootLoader       | OpenCore 0.7.6                         | 欧鹏内核 引导程序 0.7.6 版本         |

![image](https://github.com/dfc643/Lenovo-M710q-QNVH-Hackintosh-HDMI/blob/main/Screenshots/pc.png?raw=true)  

![image](https://github.com/dfc643/Lenovo-M710q-QNVH-Hackintosh-HDMI/blob/main/Screenshots/dp2hdmi.png?raw=true)  
DP 转换器购买链接：https://detail.tmall.com/item.htm?id=610696118897&spm=a1z09.2.0.0.73602e8d2NEAIi&_u=ab63k7a4c1e&skuId=4512806640067

### What Works / 通过测试项目 :

- [x] Intel UHD Graphics 630 iGPU DP Output | 英特尔核心显卡 DP 输出
- [x] DP to HDMI Adapter | 淘宝 20 包邮的 DP 转 HDMI 转换器
- [x] ALC294 Internal Speakers | 机箱内置蜂鸣器
- [x] ALC294 & DP Audio Output | 极为先进的 3.5 毫米接口及 DP 音频输出
- [x] ALC294 Audio Input | 极为先进的 3.5 毫米线路输入口
- [x] All USB Ports | 前后面板所有 USB 端口
- [x] Intel I219-V | 英特尔 I219-V 有线网卡
- [x] Intel Wi-Fi & Bluetooth | 英特尔无线网卡与蓝牙模块
- [x] NVRAM | 非易失性随机访问存储器

### UEFI Firmware / UEFI 固件 :

* Update BIOS to ```M710q-M1AKT51A.bin```
* 将固件更新至 M1AKT51A 版本，也可以用本仓库提供的版本

* Disable: CSM
* 禁用：CSM 功能

### 原作者寄语 (wxjiyc)
```
更新BIOS到最新并魔改，不然安装会报多线程的错误（不懂可以看[BV1Ab4y1Z781](https://www.bilibili.com/video/BV1Ab4y1Z781)）  
在BIOS中必须完全关闭CSM，使用UEFI引导
然后重启安装macOS  
0.7.0及以后版本中加入了引导主题和开机声音，4K显示器显示主题可能会有黑边，把config.plist里NVRAM中的UIScale改为02即可  
```

### 关于 TPM
M710q 自带了 IFX 英飞凌 TPM 芯片，支持 TPM 1.2 和 2.0 标准。我曾经让它工作在 1.2 模式过，但切换到 2.0 后 TPM 模块不再工作。这里把 TPM 模块固件分享出来，给有需要的人研究。

## Credits / 致谢名单

- [wxjiyc](https://github.com/wxjiyc/Lenovo-M710q-QNCT-Hackintosh) based on @wxjiyc's EFI files.
- [Apple](https://apple.com) for macOS.
- [Acidanthera](https://github.com/acidanthera) for OpenCore and all the lovely hackintosh work.
- [Dortania](https://github.com/dortania) for great and detailed guides.
