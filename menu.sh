#!/usr/bin/env bash
export LANG=en_US.UTF-8

# 当前脚本版本号
VERSION=2.46

# 选择 IP API 服务商
IP_API=https://api.ip.sb/geoip; ISP=isp
#IP_API=https://ifconfig.co/json; ISP=asn_org
#IP_API=https://ip.gs/json; ISP=asn_org

E[0]="\n Language:\n 1. English (default) \n 2. 简体中文\n"
C[0]="${E[0]}"
E[1]="Switch the IPv4 / IPv6 priority by [warp s 4/6/d]."
C[1]="通过 [warp s 4/6/d] 来切换 IPv4 / IPv6 的优先级别"
E[2]="The script must be run as root, you can enter sudo -i and then download and run again. Feedback: [https://github.com/fscarmen/warp/issues]"
C[2]="必须以root方式运行脚本，可以输入 sudo -i 后重新下载运行，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[3]="The TUN module is not loaded. You should turn it on in the control panel. Ask the supplier for more help. Feedback: [https://github.com/fscarmen/warp/issues]"
C[3]="没有加载 TUN 模块，请在管理后台开启或联系供应商了解如何开启，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[4]="The WARP server cannot be connected. It may be a China Mainland VPS. You can manually ping 162.159.193.10 or ping -6 2606:4700:d0::a29f:c001.You can run the script again if the connect is successful. Feedback: [https://github.com/fscarmen/warp/issues]"
C[4]="与 WARP 的服务器不能连接,可能是大陆 VPS，可手动 ping 162.159.193.10 或 ping -6 2606:4700:d0::a29f:c001，如能连通可再次运行脚本，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[5]="The script supports Debian, Ubuntu, CentOS, Arch or Alpine systems only. Feedback: [https://github.com/fscarmen/warp/issues]"
C[5]="本脚本只支持 Debian、Ubuntu、CentOS、Arch 或 Alpine 系统,问题反馈:[https://github.com/fscarmen/warp/issues]"
E[6]="warp h (help)\n warp n (Get the WARP IP)\n warp o (Turn off WARP temporarily)\n warp u (Turn off and uninstall WARP interface and Socks5 Linux Client)\n warp b (Upgrade kernel, turn on BBR, change Linux system)\n warp a (Change account to Free, WARP+ or Teams)\n warp p (Getting WARP+ quota by scripts)\n warp v (Sync the latest version)\n warp r (Connect/Disconnect WARP Linux Client)\n warp 4/6 (Add WARP IPv4/IPv6 interface)\n warp d (Add WARP dualstack interface IPv4 + IPv6)\n warp c (Install WARP Linux Client and set to proxy mode)\n warp l (Install WARP Linux Client and set to WARP mode)\n warp i (Change the WARP IP to support Netflix)\n warp e (Install Iptables + dnsmasq + ipset solution)\n warp w (Install WireProxy solution)\n warp y (Connect/Disconnect WireProxy socks5)\n warp s 4/6/d (Set stack proiority: IPv4 / IPv6 / VPS default)\n"
C[6]="warp h (帮助菜单）\n warp n (获取 WARP IP)\n warp o (临时warp开关)\n warp u (卸载 WARP 网络接口和 Socks5 Client)\n warp b (升级内核、开启BBR及DD)\n warp a (更换账户为 Free，WARP+ 或 Teams)\n warp p (刷WARP+流量)\n warp v (同步脚本至最新版本)\n warp r (WARP Linux Client 开关)\n warp 4/6 (WARP IPv4/IPv6 单栈)\n warp d (WARP 双栈)\n warp c (安装 WARP Linux Client，开启 Socks5 代理模式)\n warp l (安装 WARP Linux Client，开启 WARP 模式)\n warp i (更换支持 Netflix 的IP)\n warp e (安装 Iptables + dnsmasq + ipset 解决方案)\n warp w (安装 WireProxy 解决方案)\n warp y (WireProxy socks5 开关)\n warp s 4/6/d (优先级: IPv4 / IPv6 / VPS default)\n"
E[7]="Install dependence-list:"
C[7]="安装依赖列表:"
E[8]="All dependencies already exist and do not need to be installed additionally."
C[8]="所有依赖已存在，不需要额外安装"
E[9]="Client cannot be upgraded to a Teams account."
C[9]="Client 不能升级为 Teams 账户"
E[10]="WireGuard tools are not installed or the configuration file wgcf.conf cannot be found, please reinstall."
C[10]="没有安装 WireGuard tools 或者找不到配置文件 wgcf.conf，请重新安装。"
E[11]="Maximum \${j} attempts to get WARP IP..."
C[11]="后台获取 WARP IP 中,最大尝试\${j}次……"
E[12]="Try \${i}"
C[12]="第\${i}次尝试"
E[13]="There have been more than \${j} failures. The script is aborted. Feedback: [https://github.com/fscarmen/warp/issues]"
C[13]="失败已超过\${j}次，脚本中止，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[14]="Got the WARP\$TYPE IP successfully."
C[14]="已成功获取 WARP\$TYPE 网络"
E[15]="WARP is turned off. It could be turned on again by [warp o]"
C[15]="已暂停 WARP，再次开启可以用 warp o"
E[16]="The script specifically adds WARP network interface for VPS, detailed:[https://github.com/fscarmen/warp]\n Features:\n\t • Support WARP+ account. Third-party scripts are use to increase WARP+ quota or upgrade kernel.\n\t • Not only menus, but commands with option.\n\t • Support system: Ubuntu 16.04、18.04、20.04、22.04,Debian 9、10、11,CentOS 7、8、9, Alpine, Arch Linux 3.\n\t • Support architecture: AMD,ARM and s390x\n\t • Automatically select four WireGuard solutions. Performance: Kernel with WireGuard integration > Install kernel module > wireguard-go\n\t • Intelligent analysis of the latest version of the WGCF\n\t • Suppert WARP Linux client.\n\t • Output WARP status, IP region and asn\n"
C[16]="本项目专为 VPS 添加 wgcf 网络接口，详细说明: [https://github.com/fscarmen/warp]\n 脚本特点:\n\t • 支持 WARP+ 账户，附带第三方刷 WARP+ 流量和升级内核 BBR 脚本\n\t • 普通用户友好的菜单，进阶者通过后缀选项快速搭建\n\t • 智能判断操作系统: Ubuntu 、Debian 、CentOS、 Alpine 和 Arch Linux，请务必选择 LTS 系统\n\t • 支持硬件结构类型: AMD、 ARM 和 s390x\n\t • 结合 Linux 版本和虚拟化方式，自动优选4个 WireGuard 方案。网络性能方面: 内核集成 WireGuard > 安装内核模块 > wireguard-go\n\t • 智能判断 WGCF 作者 github库的最新版本 （Latest release）\n\t • 支持 WARP Linux Socks5 Client\n\t • 输出执行结果，提示是否使用 WARP IP ，IP 归属地和线路提供商\n"
E[17]="Version"
C[17]="脚本版本"
E[18]="New features"
C[18]="功能新增"
E[19]="System infomation"
C[19]="系统信息"
E[20]="Operating System"
C[20]="当前操作系统"
E[21]="Kernel"
C[21]="内核"
E[22]="Architecture"
C[22]="处理器架构"
E[23]="Virtualization"
C[23]="虚拟化"
E[24]="Client is on"
C[24]="Client 已开启"
E[25]="Device name"
C[25]="设备名"
E[26]="Curren operating system is \$SYS.\\\n The system lower than \$SYSTEM \${MAJOR[int]} is not supported. Feedback: [https://github.com/fscarmen/warp/issues]"
C[26]="当前操作是 \$SYS\\\n 不支持 \$SYSTEM \${MAJOR[int]} 以下系统,问题反馈:[https://github.com/fscarmen/warp/issues]"
E[27]="Local Socks5"
C[27]="本地 Socks5"
E[28]="If there is a WARP+ License, please enter it, otherwise press Enter to continue:"
C[28]="如有 WARP+ License 请输入，没有可回车继续:"
E[29]="Input errors up to 5 times.The script is aborted."
C[29]="输入错误达5次，脚本退出"
E[30]="License should be 26 characters, please re-enter WARP+ License. Otherwise press Enter to continue. \(\${i} times remaining\):"
C[30]="License 应为26位字符，请重新输入 WARP+ License，没有可回车继续\(剩余\${i}次\):"
E[31]="The new \$KEY_LICENSE is the same as the one currently in use. Does not need to be replaced."
C[31]="新输入的 \$KEY_LICENSE 与现使用中的一样，不需要更换。"
E[32]="Step 1/3: Install dependencies..."
C[32]="进度 1/3: 安装系统依赖……"
E[33]="Step 2/3: WGCF is ready"
C[33]="进度 2/3: 已安装 WGCF"
E[34]="Failed to change port. Feedback: [https://github.com/fscarmen/warp/issues]"
C[34]="更换端口不成功，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[35]="Update WARP+ account..."
C[35]="升级 WARP+ 账户中……"
E[36]="The upgrade failed, License: \$LICENSE has been activated on more than 5 devices. The script will remain the same account or be switched to a free account."
C[36]="升级失败，License: \$LICENSE 已激活超过5台设备，将保持原账户或者转为免费账户。"
E[37]="Checking VPS infomation..."
C[37]="检查环境中……"
E[38]="Create shortcut [warp] successfully"
C[38]="创建快捷 warp 指令成功"
E[39]="Running WARP"
C[39]="运行 WARP"
E[40]="\$COMPANY vps needs to restart and run [warp n] to open WARP."
C[40]="\$COMPANY vps 需要重启后运行 warp n 才能打开 WARP,现执行重启"
E[41]="Congratulations! WARP\$TYPE is turned on. Spend time:\$(( end - start )) seconds.\\\n The script runs today: \$TODAY. Total:\$TOTAL"
C[41]="恭喜！WARP\$TYPE 已开启，总耗时:\$(( end - start ))秒， 脚本当天运行次数:\$TODAY，累计运行次数:\$TOTAL"
E[42]="The upgrade failed, License: \$LICENSE could not update to WARP+. The script will remain the same account or be switched to a free account."
C[42]="升级失败，License: \$LICENSE 不能升级为 WARP+，将保持原账户或者转为免费账户。"
E[43]="Run again with warp [option] [lisence], such as"
C[43]="再次运行用 warp [option] [lisence]，如"
E[44]="WARP installation failed. Feedback: [https://github.com/fscarmen/warp/issues]"
C[44]="WARP 安装失败，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[45]="WARP interface, Linux Client and WirePorxy have been completely deleted!"
C[45]="WARP 网络接口、 Linux Client 和 WirePorxy 已彻底删除!"
E[46]="Not cleaned up, please reboot and try again."
C[46]="没有清除干净，请重启(reboot)后尝试再次删除"
E[47]="Upgrade kernel, turn on BBR, change Linux system by other authors [ylx2016],[https://github.com/ylx2016/Linux-NetSpeed]"
C[47]="BBR、DD脚本用的[ylx2016]的成熟作品，地址[https://github.com/ylx2016/Linux-NetSpeed]，请熟知"
E[48]="Run script"
C[48]="安装脚本"
E[49]="Return to main menu"
C[49]="回退主目录"
E[50]="Choose:"
C[50]="请选择:"
E[51]="Please enter the correct number"
C[51]="请输入正确数字"
E[52]="Please input WARP+ ID:"
C[52]="请输入 WARP+ ID:"
E[53]="WARP+ ID should be 36 characters, please re-enter \(\${i} times remaining\):"
C[53]="WARP+ ID 应为36位字符，请重新输入 \(剩余\${i}次\):"
E[54]="Getting the WARP+ quota by the following 3 authors:\n	• [ALIILAPRO]，[https://github.com/ALIILAPRO/warp-plus-cloudflare]\n	• [mixool]，[https://github.com/mixool/across/tree/master/wireguard]\n	• [SoftCreatR]，[https://github.com/SoftCreatR/warp-up]\n • Open the 1.1.1.1 app\n • Click on the hamburger menu button on the top-right corner\n • Navigate to: Account > Key\n Important:Refresh WARP+ quota: 三 --> Advanced --> Connection options --> Reset keys\n It is best to run script with screen."
C[54]="刷 WARP+ 流量用可选择以下三位作者的成熟作品，请熟知:\n	• [ALIILAPRO]，地址[https://github.com/ALIILAPRO/warp-plus-cloudflare]\n	• [mixool]，地址[https://github.com/mixool/across/tree/master/wireguard]\n	• [SoftCreatR]，地址[https://github.com/SoftCreatR/warp-up]\n 下载地址:https://1.1.1.1/，访问和苹果外区 ID 自理\n 获取 WARP+ ID 填到下面。方法:App右上角菜单 三 --> 高级 --> 诊断 --> ID\n 重要:刷脚本后流量没有增加处理:右上角菜单 三 --> 高级 --> 连接选项 --> 重置加密密钥\n 最好配合 screen 在后台运行任务"
E[55]="1. Run [ALIILAPRO] script\n 2. Run [mixool] script\n 3. Run [SoftCreatR] script"
C[55]="1. 运行 [ALIILAPRO] 脚本\n 2. 运行 [mixool] 脚本\n 3. 运行 [SoftCreatR] 脚本"
E[56]="The current Netflix region is \$REGION. Confirm press [y] . If you want another regions, please enter the two-digit region abbreviation. \(such as hk,sg. Default is \$REGION\):"
C[56]="当前 Netflix 地区是:\$REGION，需要解锁当前地区请按 [y], 如需其他地址请输入两位地区简写 \(如 hk ,sg，默认:\$REGION\):"
E[57]="The target quota you want to get. The unit is GB, the default value is 10:"
C[57]="你希望获取的目标流量值，单位为 GB，输入数字即可，默认值为10:"
E[58]="Glibc 2.28 download failed. The script is aborted. Feedback: [https://github.com/fscarmen/warp/issues] "
C[58]="Glibc 2.28 下载失败，脚本中止，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[59]="Cannot find the account file: /etc/wireguard/wgcf-account.toml, you can reinstall with the WARP+ License"
C[59]="找不到账户文件:/etc/wireguard/wgcf-account.toml，可以卸载后重装，输入 WARP+ License"
E[60]="Cannot find the configuration file: /etc/wireguard/wgcf.conf, you can reinstall with the WARP+ License"
C[60]="找不到配置文件: /etc/wireguard/wgcf.conf，可以卸载后重装，输入 WARP+ License"
E[61]="Please Input WARP+ license:"
C[61]="请输入WARP+ License:"
E[62]="Successfully change to a WARP\$TYPE account"
C[62]="已变更为 WARP\$TYPE 账户"
E[63]="WARP+ quota"
C[63]="剩余流量"
E[64]="Successfully synchronized the latest version"
C[64]="成功！已同步最新脚本，版本号"
E[65]="Upgrade failed. Feedback:[https://github.com/fscarmen/warp/issues]"
C[65]="升级失败，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[66]="Add WARP IPv4 interface to \${NATIVE[n]} VPS \(bash menu.sh 4\)"
C[66]="为 \${NATIVE[n]} 添加 WARP IPv4 网络接口 \(bash menu.sh 4\)"
E[67]="Add WARP IPv6 interface to \${NATIVE[n]} VPS \(bash menu.sh 6\)"
C[67]="为 \${NATIVE[n]} 添加 WARP IPv6 网络接口 \(bash menu.sh 6\)"
E[68]="Add WARP dualstack interface to \${NATIVE[n]} VPS \(bash menu.sh d\)"
C[68]="为 \${NATIVE[n]} 添加 WARP 双栈网络接口 \(bash menu.sh d\)"
E[69]="Native dualstack"
C[69]="原生双栈"
E[70]="WARP dualstack"
C[70]="WARP 双栈"
E[71]="Turn on WARP (warp o)"
C[71]="打开 WARP (warp o)"
E[72]="Turn off, uninstall WARP interface, Linux Client and WireProxy (warp u)"
C[72]="永久关闭 WARP 网络接口，并删除 WARP、 Linux Client 和 WireProxy (warp u)"
E[73]="Upgrade kernel, turn on BBR, change Linux system (warp b)"
C[73]="升级内核、安装BBR、DD脚本 (warp b)"
E[74]="Getting WARP+ quota by scripts (warp p)"
C[74]="刷 WARP+ 流量 (warp p)"
E[75]="Sync the latest version (warp v)"
C[75]="同步最新版本 (warp v)"
E[76]="Exit"
C[76]="退出脚本"
E[77]="Turn off WARP (warp o)"
C[77]="暂时关闭 WARP (warp o)"
E[78]="Change the WARP account type (warp a)"
C[78]="变更 WARP 账户 (warp a)"
E[79]="Do you uninstall the following dependencies \(if any\)? Please note that this will potentially prevent other programs that are using the dependency from working properly.\\\n\\\n \$UNINSTALL_DEPENDENCIES_LIST"
C[79]="是否卸载以下依赖\(如有\)？请注意，这将有可能使其他正在使用该依赖的程序不能正常工作\\\n\\\n \$UNINSTALL_DEPENDENCIES_LIST"
E[80]="Professional one-click script for WARP to unblock streaming media (Supports multi-platform, multi-mode and TG push)"
C[80]="WARP 解锁 Netflix 等流媒体专业一键(支持多平台、多方式和 TG 通知)"
E[81]="Step 3/3: Searching for the best MTU value is ready."
C[81]="进度 3/3: 寻找 MTU 最优值已完成"
E[82]="Install CloudFlare Client and set mode to Proxy (bash menu.sh c)"
C[82]="安装 CloudFlare Client 并设置为 Proxy 模式 (bash menu.sh c)"
E[83]="Step 1/2: Installing WARP Client..."
C[83]="进度 1/2: 安装 Client……"
E[84]="Step 2/2: Setting Client Mode"
C[84]="进度 2/2: 设置 Client 模式"
E[85]="Client was installed.\n connect/disconnect by [warp r].\n uninstall by [warp u]"
C[85]="Linux Client 已安装\n 连接/断开: warp r\n 卸载: warp u"
E[86]="Client is working. Socks5 proxy listening on: \$(ss -nltp | grep -E 'warp|wireproxy' | awk '{print \$(NF-2)}')"
C[86]="Linux Client 正常运行中。 Socks5 代理监听:\$(ss -nltp | grep -E 'warp|wireproxy' | awk '{print \$(NF-2)}')"
E[87]="Fail to establish Socks5 proxy. Feedback: [https://github.com/fscarmen/warp/issues]"
C[87]="创建 Socks5 代理失败，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[88]="Connect the client (warp r)"
C[88]="连接 Client (warp r)"
E[89]="Disconnect the client (warp r)"
C[89]="断开 Client (warp r)"
E[90]="Client is connected"
C[90]="Client 已连接"
E[91]="Client is disconnected. It could be connect again by [warp r]"
C[91]="已断开 Client，再次连接可以用 warp r"
E[92]="(!!! Already installed, do not select.)"
C[92]="(!!! 已安装，请勿选择)"
E[93]="Client is not installed."
C[93]="Client 未安装"
E[94]="Congratulations! WARP\$AC Linux Client is working. Spend time:\$(( end - start )) seconds.\\\n The script runs on today: \$TODAY. Total:\$TOTAL"
C[94]="恭喜！WARP\$AC Linux Client 工作中, 总耗时:\$(( end - start ))秒， 脚本当天运行次数:\$TODAY，累计运行次数:\$TOTAL"
E[95]="Client works with non-WARP IPv4. The script is aborted. Feedback: [https://github.com/fscarmen/warp/issues]"
C[95]="Client 在非 WARP IPv4 下才能工作正常，脚本中止，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[96]="Client connecting failure. It may be a CloudFlare IPv4."
C[96]="Client 连接失败，可能是 CloudFlare IPv4."
E[97]="IPv\$PRIO priority"
C[97]="IPv\$PRIO 优先"
E[98]="Uninstall WirePorxy was complete."
C[98]="WirePorxy 卸载成功"
E[99]="WireProxy is connected"
C[99]="WireProxy 已连接"
E[100]="License should be 26 characters, please re-enter WARP+ License. Otherwise press Enter to continue. \(\${i} times remaining\): "
C[100]="License 应为26位字符,请重新输入 WARP+ License \(剩余\${i}次\): "
E[101]="Client support amd64 only. Curren architecture \$ARCHITECTURE. Official Support List: [https://pkg.cloudflareclient.com/packages/cloudflare-warp]. The script is aborted. Feedback: [https://github.com/fscarmen/warp/issues]"
C[101]="Client 只支持 amd64 架构，当前架构 \$ARCHITECTURE，官方支持列表: [https://pkg.cloudflareclient.com/packages/cloudflare-warp]。问题反馈:[https://github.com/fscarmen/warp/issues]"
E[102]="Please customize the WARP+ device name (Default is [WARP] if left blank):"
C[102]="请自定义 WARP+ 设备名 (如果不输入，默认为 [WARP]):"
E[103]="Port \$PORT is in use. Please input another Port\(\${i} times remaining\):"
C[103]="\$PORT 端口占用中，请使用另一端口\(剩余\${i}次\):"
E[104]="Please customize the Client port (1000-65535. Default to 40000 if it is blank):"
C[104]="请自定义 Client 端口号 (1000-65535，如果不输入，会默认40000):"
E[105]="Please choose the priority:\n 1. IPv4\n 2. IPv6\n 3. Use initial settings (default)"
C[105]="请选择优先级别:\n 1. IPv4\n 2. IPv6\n 3. 使用 VPS 初始设置 (默认)"
E[106]=""
C[106]=""
E[107]=""
C[107]=""
E[108]="\n 1. WARP Linux Client IP\n 2. WGCF WARP IP ( Only IPv6 can be brushed when WGCF and Client exist at the same time )\n"
C[108]="\n 1. WARP Linux Client IP\n 2. WGCF WARP IP ( WGCF 和 Client 并存时只能刷 IPv6)\n"
E[109]="Socks5 Proxy Client is working now. WARP IPv4 and dualstack interface could not be switch to. The script is aborted. Feedback: [https://github.com/fscarmen/warp/issues]"
C[109]="Socks5 代理正在运行中，不能转为 WARP IPv4 或者双栈网络接口，脚本中止，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[110]="Socks5 Proxy Client is working now. WARP IPv4 and dualstack interface could not be installed. The script is aborted. Feedback: [https://github.com/fscarmen/warp/issues]"
C[110]="Socks5 代理正在运行中，WARP IPv4 或者双栈网络接口不能安装，脚本中止，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[111]="Port must be 1000-65535. Please re-input\(\${i} times remaining\):"
C[111]="端口必须为 1000-65535，请重新输入\(剩余\${i}次\):"
E[112]="Client is not installed."
C[112]="Client 未安装"
E[113]="Client is installed. Mode is \$CLIENT_MODE. Disconnected"
C[113]="Client 已安装，模式为:\$CLIENT_MODE， 断开状态"
E[114]="WARP\$TYPE Interface is on"
C[114]="WARP\$TYPE 网络接口已开启"
E[115]="WARP Interface is on"
C[115]="WARP 网络接口已开启"
E[116]="WARP Interface is off"
C[116]="WARP 网络接口未开启"
E[117]="Uninstall WARP Interface was complete."
C[117]="WARP 网络接口卸载成功"
E[118]="Uninstall WARP Interface was fail."
C[118]="WARP 网络接口卸载失败"
E[119]="Uninstall Socks5 Proxy Client was complete."
C[119]="Socks5 Proxy Client 卸载成功"
E[120]="Uninstall Socks5 Proxy Client was fail."
C[120]="Socks5 Proxy Client 卸载失败"
E[121]="Changing Netflix IP is adapted from other authors [luoxue-bot],[https://github.com/luoxue-bot/warp_auto_change_ip]"
C[121]="更换支持 Netflix IP 改编自 [luoxue-bot] 的成熟作品，地址[https://github.com/luoxue-bot/warp_auto_change_ip]，请熟知"
E[122]="Port change to \$PORT succeeded."
C[122]="端口成功更换至 \$PORT"
E[123]="Change the WARP IP to support Netflix (warp i)"
C[123]="更换支持 Netflix 的 IP (warp i)"
E[124]="1. Brush WARP IPv4 (default)\n 2. Brush WARP IPv6"
C[124]="1. 刷 WARP IPv4 (默认)\n 2. 刷 WARP IPv6"
E[125]="\$(date +'%F %T') Region: \$REGION Done. IPv\$NF: \$WAN  \$COUNTRY  \$ASNORG. Retest after 1 hour. Brush ip runing time:\$DAY days \$HOUR hours \$MIN minutes \$SEC seconds" 
C[125]="\$(date +'%F %T') 区域 \$REGION 解锁成功，IPv\$NF: \$WAN  \$COUNTRY  \$ASNORG，1 小时后重新测试，刷 IP 运行时长: \$DAY 天 \$HOUR 时 \$MIN 分 \$SEC 秒"
E[126]="\$(date +'%F %T') Try \${i}. Failed. IPv\$NF: \$WAN  \$COUNTRY  \$ASNORG. Retry after \${j} seconds. Brush ip runing time:\$DAY days \$HOUR hours \$MIN minutes \$SEC seconds" 
C[126]="\$(date +'%F %T') 尝试第\${i}次，解锁失败，IPv\$NF: \$WAN  \$COUNTRY  \$ASNORG，\${j}秒后重新测试，刷 IP 运行时长: \$DAY 天 \$HOUR 时 \$MIN 分 \$SEC 秒"
E[127]="Please input Teams file URL (To use the one provided by the script if left blank):" 
C[127]="请输入 Teams 文件 URL (如果留空，则使用脚本提供的):"
E[128]=""
C[128]=""
E[129]="The current Teams account is unavailable, automatically switch back to the free account"
C[129]="当前 Teams 账户不可用，自动切换回免费账户"
E[130]="Please confirm\\\n Private key\\\t: \$PRIVATEKEY \$MATCH1\\\n Public key\\\t: \$PUBLICKEY \$MATCH2\\\n Address IPv4\\\t: \$ADDRESS4/32 \$MATCH3\\\n Address IPv6\\\t: \$ADDRESS6/128 \$MATCH4"
C[130]="请确认Teams 信息\\\n Private key\\\t: \$PRIVATEKEY \$MATCH1\\\n Public key\\\t: \$PUBLICKEY \$MATCH2\\\n Address IPv4\\\t: \$ADDRESS4/32 \$MATCH3\\\n Address IPv6\\\t: \$ADDRESS6/128 \$MATCH4"
E[131]="comfirm please enter [y] , and other keys to use free account:"
C[131]="确认请按 [y]，其他按键则使用免费账户:"
E[132]="Is there a WARP+ or Teams account?\n 1. Use free account (default)\n 2. WARP+\n 3. Teams"
C[132]="如有 WARP+ 或 Teams 账户请选择\n 1. 使用免费账户 (默认)\n 2. WARP+\n 3. Teams"
E[133]="Device name: \$(grep -s 'Device name' /etc/wireguard/info.log | awk '{ print \$NF }')\\\n Quota: \$QUOTA"
C[133]="设备名: \$(grep -s 'Device name' /etc/wireguard/info.log | awk '{ print \$NF }')\\\n 剩余流量: \$QUOTA"
E[134]="Curren architecture \$(uname -m) is not supported. Feedback: [https://github.com/fscarmen/warp/issues]"
C[134]="当前架构 \$(uname -m) 暂不支持,问题反馈:[https://github.com/fscarmen/warp/issues]"
E[135]="( match √ )"
C[135]="( 符合 √ )"
E[136]="( mismatch X )"
C[136]="( 不符合 X )"
E[137]="Cannot find the configuration file: /etc/wireguard/wgcf.conf. You should install WARP first"
C[137]="找不到配置文件 /etc/wireguard/wgcf.conf，请先安装 WARP"
E[138]="Install iptable + dnsmasq + ipset. Let WARP only take over the streaming media traffic (Not available for ipv6 only) (bash menu.sh e)"
C[138]="安装 iptable + dnsmasq + ipset，让 WARP IPv4 only 接管流媒体流量 (不适用于 IPv6 only VPS) (bash menu.sh e)"
E[139]="Through Iptable + dnsmasq + ipset, minimize the realization of media unblocking such as Netflix, WARP IPv4 only takes over the streaming media traffic,adapted from the mature works of [Anemone],[https://github.com/acacia233/Project-WARP-Unlock]"
C[139]="通过 Iptable + dnsmasq + ipset，最小化实现 Netflix 等媒体解锁，WARP IPv4 只接管流媒体流量，改编自 [Anemone] 的成熟作品，地址[https://github.com/acacia233/Project-WARP-Unlock]，请熟知"
E[140]="Socks5 Proxy Client on IPv4 VPS is working now. WARP IPv6 interface could not be installed. Feedback: [https://github.com/fscarmen/warp/issues]"
C[140]="IPv4 only VPS，并且 Socks5 代理正在运行中，不能安装 WARP IPv6 网络接口，问题反馈:[https://github.com/fscarmen/warp/issues]"
E[141]="Switch \${WARP_BEFORE[m]} to \${WARP_AFTER1[m]} \${SHORTCUT1[m]}"
C[141]="\${WARP_BEFORE[m]} 转为 \${WARP_AFTER1[m]} \${SHORTCUT1[m]}"
E[142]="Switch \${WARP_BEFORE[m]} to \${WARP_AFTER2[m]} \${SHORTCUT2[m]}"
C[142]="\${WARP_BEFORE[m]} 转为 \${WARP_AFTER2[m]} \${SHORTCUT2[m]}"
E[143]="Change Client or WireProxy port"
C[143]="更改 Client 或 WireProxy 端口"
E[144]="Install WARP IPv6 interface"
C[144]="安装 WARP IPv6 网络接口"
E[145]=""
C[145]=""
E[146]="Cannot switch to the same form as the current one."
C[146]="不能切换为当前一样的形态"
E[147]="Not available for IPv6 only VPS"
C[147]="IPv6 only VPS 不能使用此方案"
E[148]="Install wireproxy. Wireguard client that exposes itself as a socks5 proxy or tunnels (bash menu.sh w)"
C[148]="安装 wireproxy，让 WARP 在本地创建一个 socks5 代理 (bash menu.sh w)"
E[149]="Congratulations! WirePorxy is working. Spend time:\$(( end - start )) seconds.\\\n The script runs on today: \$TODAY. Total:\$TOTAL"
C[149]="恭喜！WirePorxy 工作中, 总耗时:\$(( end - start ))秒， 脚本当天运行次数:\$TODAY，累计运行次数:\$TOTAL"
E[150]="WGCF WARP, WARP Linux Client, WireProxy hasn't been installed yet. The script is aborted.\n"
E[151]="1. WARP Linux Client account\n 2. WireProxy account"
C[151]="1. WARP Linux Client 账户\n 2. WireProxy 账户"
E[152]="1. WGCF WARP account\n 2. WireProxy account"
C[152]="1. WGCF WARP 账户\n 2. WireProxy 账户"
E[153]="1. WGCF WARP account\n 2. WARP Linux Client account"
C[153]="1. WGCF WARP 账户\n 2. WARP Linux Client 账户"
E[154]="1. WGCF WARP account\n 2. WARP Linux Client account\n 3. WireProxy account"
C[154]="1. WGCF WARP 账户\n 2. WARP Linux Client 账户\n 3. WireProxy 账户"
E[155]="WGCF WARP has not been installed yet."
C[155]="WGCF WARP 还未安装"
E[156]="(!!! AMD64 only, do not select.)"
C[156]="(!!! 只支持 AMD64，请勿选择)"
E[157]="WireProxy has not been installed yet."
C[157]="WireProxy 还未安装"
E[158]="WireProxy is disconnected. It could be connect again by [warp y]"
C[158]="已断开 WirePorxy，再次连接可以用 warp y"
E[159]="WireProxy is on"
C[159]="WireProxy 已开启"
E[160]="WireProxy is not installed."
C[160]="WireProxy 未安装"
E[161]="WireProxy is installed and disconnected"
C[161]="WireProxy 已安装，状态为断开连接"
E[162]=""
C[162]=""
E[163]="Connect the WirePorxy (warp y)"
C[163]="连接 WirePorxy (warp y)"
E[164]="Disconnect the WirePorxy (warp y)"
C[164]="断开 WirePorxy (warp y)"
E[165]="WireProxy Solution. A wireguard client that exposes itself as a socks5 proxy or tunnels. Adapted from the mature works of [octeep],[https://github.com/octeep/wireproxy]"
C[165]="WireProxy，让 WARP 在本地建议一个 socks5 代理。改编自 [octeep] 的成熟作品，地址[https://github.com/octeep/wireproxy]，请熟知"
E[166]="WireProxy was installed.\n connect/disconnect by [warp y]\n uninstall by [warp u]"
C[166]="WireProxy 已安装\n 连接/断开: warp y\n 卸载: warp u"
E[167]="WARP iptable was installed.\n connect/disconnect by [warp o]\n uninstall by [warp u]"
C[167]="WARP iptable 已安装\n 连接/断开: warp o\n 卸载: warp u"
E[168]="Install CloudFlare Client and set mode to WARP (bash menu.sh l)"
C[168]="安装 CloudFlare Client 并设置为 WARP 模式 (bash menu.sh l)"
E[169]="WARP\$AC IPv4: \$WAN4 \$WARPSTATUS4 \$COUNTRY4  \$ASNORG4"
C[169]="WARP\$AC IPv4: \$WAN4 \$WARPSTATUS4 \$COUNTRY4  \$ASNORG4"
E[170]="Confirm all uninstallation please press [y], other keys do not uninstall by default:"
C[170]="确认全部卸载请按 [y]，其他键默认不卸载:"
E[171]="Uninstall dependencies were complete."
C[171]="依赖卸载成功"
E[172]="No suitable solution was found for modifying the wgcf configuration file wgcf.conf and the script aborted. When you see this message, please send feedback on the bug to:[https://github.com/fscarmen/warp/issues]"
C[172]="没有找到适合的方案用于修改 wgcf 配置文件 wgcf.conf，脚本中止。当你看到此信息，请把该 bug 反馈至:[https://github.com/fscarmen/warp/issues]"
E[173]="Current account type is: WARP \$ACCOUNT_TYPE\\\t \$PLUS_QUOTA\\\n \$CHANGE_TYPE"
C[173]="当前账户类型是: WARP \$ACCOUNT_TYPE\\\t \$PLUS_QUOTA\\\n \$CHANGE_TYPE"
E[174]="1. Continue using the free account without changing.\n 2. Change to WARP+ account.\n 3. Change to Teams account. (You need upload the Teams file to a private storage space before. For example: gist.github.com)"
C[174]="1. 继续使用 free 账户，不变更\n 2. 变更为 WARP+ 账户\n 3. 变更为 Teams 账户 (你须事前把 Teams 文件上传到私密存储空间，比如:gist.github.com)"
E[175]="1. Change to free account.\n 2. Change to WARP+ account.\n 3. Change to another WARP Teams account. (You need upload the Teams file to a private storage space before. For example: gist.github.com)"
C[175]="1. 变更为 free 账户\n 2. 变更为 WARP+ 账户\n 3. 更换为另一个 Teams 账户 (你须事前把 Teams 文件上传到私密存储空间，比如:gist.github.com)"
E[176]="1. Change to free account.\n 2. Change to another WARP+ account.\n 3. Change to Teams account. (You need upload the Teams file to a private storage space before. For example: gist.github.com)"
C[176]="1. 变更为 free 账户\n 2. 变更为另一个 WARP+ 账户\n 3. 变更为 Teams 账户 (你须事前把 Teams 文件上传到私密存储空间，比如:gist.github.com)"
E[177]="1. Continue using the free account without changing.\n 2. Change to WARP+ account."
C[177]="1. 继续使用 free 账户，不变更\n 2. 变更为 WARP+ 账户"
E[178]="1. Change to free account.\n 2. Change to another WARP+ account."
C[178]="1. 变更为 free 账户\n 2. 变更为另一个 WARP+ 账户"

# 自定义字体彩色，read 函数，友道翻译函数
warning() { echo -e "\033[31m\033[01m$*\033[0m"; }
error() { echo -e "\033[31m\033[01m$*\033[0m" && exit 1; }
info() { echo -e "\033[32m\033[01m$*\033[0m"; }
hint() { echo -e "\033[33m\033[01m$*\033[0m"; }
reading() { read -rp "$(info "$1")" "$2"; }
text() { eval echo "\${${L}[$*]}"; }
text_eval() { eval echo "\$(eval echo "\${${L}[$*]}")"; }
translate() { [ -n "$1" ] && curl -ksm8 "http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i=$1" | cut -d \" -f18 2>/dev/null; }

# 脚本当天及累计运行次数统计
statistics_of_run-times() {
COUNT=$(
  curl -4 -ksm1 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fcdn.jsdelivr.net%2Fgh%2Ffscarmen%2Fwarp%2Fmenu.sh&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=&edge_flat=true" 2>&1 ||
  curl -6 -ksm1 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fcdn.jsdelivr.net%2Fgh%2Ffscarmen%2Fwarp%2Fmenu.sh&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=&edge_flat=true" 2>&1) &&
  TODAY=$(expr "$COUNT" : '.*\s\([0-9]\{1,\}\)\s/.*') && TOTAL=$(expr "$COUNT" : '.*/\s\([0-9]\{1,\}\)\s.*')
}
        
# 选择语言，先判断 /etc/wireguard/language 里的语言选择，没有的话再让用户选择，默认英语
select_language() {
  case $(cat /etc/wireguard/language 2>&1) in
    E ) L=E ;;
    C ) L=C ;;
    * ) L=E && [[ -z "$OPTION" || "$OPTION" = [aclehdpbviw46s] ]] && hint " $(text 0) " && reading " $(text 50) " LANGUAGE
    [ "$LANGUAGE" = 2 ] && L=C ;;
  esac
}

# 必须以root运行脚本
check_root_virt() {
  [ "$(id -u)" != 0 ] && error " $(text 2) "
        
  # 判断虚拟化，选择 Wireguard内核模块 还是 Wireguard-Go
  VIRT=$(systemd-detect-virt 2>/dev/null | tr 'A-Z' 'a-z')
  [ -n "$VIRT" ] || VIRT=$(hostnamectl 2>/dev/null | tr 'A-Z' 'a-z' | grep virtualization | sed "s/.*://g")
  [[ "$VIRT" =~ openvz|lxc || -z "$VIRT" ]] && LXC=1
}

# 多方式判断操作系统，试到有值为止。只支持 Debian 10/11、Ubuntu 18.04/20.04 或 CentOS 7/8 ,如非上述操作系统，退出脚本
# 感谢猫大的技术指导优化重复的命令。https://github.com/Oreomeow
check_operating_system() {
  CMD=( "$(grep -i pretty_name /etc/os-release 2>/dev/null | cut -d \" -f2)"
        "$(hostnamectl 2>/dev/null | grep -i system | cut -d : -f2)"
        "$(lsb_release -sd 2>/dev/null)"
        "$(grep -i description /etc/lsb-release 2>/dev/null | cut -d \" -f2)"
        "$(grep . /etc/redhat-release 2>/dev/null)"
        "$(grep . /etc/issue 2>/dev/null | cut -d \\ -f1 | sed '/^[ ]*$/d')"
      )

  for i in "${CMD[@]}"; do
    SYS="$i" && [ -n "$SYS" ] && break
  done

  # 自定义 Alpine 系统若干函数
  alpine_wgcf_restart() { wg-quick down wgcf >/dev/null 2>&1; wg-quick up wgcf >/dev/null 2>&1; }
  alpine_wgcf_enable() { echo -e "/usr/bin/tun.sh\nwg-quick up wgcf" > /etc/local.d/wgcf.start; chmod +x /etc/local.d/wgcf.start; rc-update add local; }

  REGEX=("debian" "ubuntu" "centos|red hat|kernel|oracle linux|alma|rocky" "amazon linux" "alpine" "arch linux")
  RELEASE=("Debian" "Ubuntu" "CentOS" "CentOS" "Alpine" "Arch")
  EXCLUDE=("bookworm")
  COMPANY=("" "" "" "amazon" "" "")
  MAJOR=("9" "16" "7" "7" "3" "")
  PACKAGE_UPDATE=("apt -y update" "apt -y update" "yum -y update" "yum -y update" "apk update -f" "pacman -Sy")
  PACKAGE_INSTALL=("apt -y install" "apt -y install" "yum -y install" "yum -y install" "apk add -f" "pacman -S --noconfirm")
  PACKAGE_UNINSTALL=("apt -y autoremove" "apt -y autoremove" "yum -y autoremove" "yum -y autoremove" "apk del -f" "pacman -Rcnsu --noconfirm")
  SYSTEMCTL_START=("systemctl start wg-quick@wgcf" "systemctl start wg-quick@wgcf" "systemctl start wg-quick@wgcf" "systemctl start wg-quick@wgcf" "wg-quick up wgcf" "systemctl start wg-quick@wgcf")
  SYSTEMCTL_RESTART=("systemctl restart wg-quick@wgcf" "systemctl restart wg-quick@wgcf" "systemctl restart wg-quick@wgcf" "systemctl restart wg-quick@wgcf" "alpine_wgcf_restart" "systemctl restart wg-quick@wgcf")
  SYSTEMCTL_ENABLE=("systemctl enable --now wg-quick@wgcf" "systemctl enable --now wg-quick@wgcf" "systemctl enable --now wg-quick@wgcf" "systemctl enable --now wg-quick@wgcf" "alpine_wgcf_enable" "systemctl enable --now wg-quick@wgcf")

  for ((int=0; int<${#REGEX[@]}; int++)); do
    [[ $(tr 'A-Z' 'a-z' <<< "$SYS") =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && COMPANY="${COMPANY[int]}" && [ -n "$SYSTEM" ] && break
  done
  [ -z "$SYSTEM" ] && error " $(text 5) "

  # 先排除 EXCLUDE 里包括的特定系统，其他系统需要作大发行版本的比较
  for ex in "${EXCLUDE[@]}"; do [[ ! $(tr 'A-Z' 'a-z' <<< "$SYS")  =~ $ex ]]; done &&
  [[ "$(echo "$SYS" | sed "s/[^0-9.]//g" | cut -d. -f1)" -lt "${MAJOR[int]}" ]] && error " $(text_eval 26) "
}

# 安装系统依赖及定义 ping 指令
check_dependencies() {
  # 对于 alpine 系统，升级库并重新安装依赖
  if [ "$SYSTEM" = Alpine ]; then
    [ ! -e /etc/wireguard/menu.sh ] && ( ${PACKAGE_UPDATE[int]}; ${PACKAGE_INSTALL[int]} curl wget grep bash )
  else
    DEPS_CHECK=("ping" "wget" "curl" "systemctl" "ip")
    DEPS_INSTALL=(" iputils-ping" " wget" " curl" " systemctl" " iproute2")
    for ((g=0; g<${#DEPS_CHECK[@]}; g++)); do [ ! $(type -p ${DEPS_CHECK[g]}) ] && DEPS+=${DEPS_INSTALL[g]}; done
    if [ -n "$DEPS" ]; then
      info "\n $(text 7) $DEPS \n"
      ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
      ${PACKAGE_INSTALL[int]} $DEPS >/dev/null 2>&1
    else
      info "\n $(text 8) \n"
    fi
  fi
  PING6='ping -6' && [ $(type -p ping6) ] && PING6='ping6'
}

# 检测 IPv4 IPv6 信息，WARP Ineterface 开启，普通还是 Plus账户 和 IP 信息
ip4_info() {
  unset IP4 COUNTRY4 ASNORG4 TRACE4 PLUS4 WARPSTATUS4
  IP4=$(curl -ks4m8 -A Mozilla $IP_API $INTERFACE)
  WAN4=$(expr "$IP4" : '.*ip\":[ ]*\"\([^"]*\).*')
  COUNTRY4=$(expr "$IP4" : '.*country\":[ ]*\"\([^"]*\).*')
  ASNORG4=$(expr "$IP4" : '.*'$ISP'\":[ ]*\"\([^"]*\).*')
  TRACE4=$(curl -ks4m8 https://www.cloudflare.com/cdn-cgi/trace | grep warp | sed "s/warp=//g")
  if [ "$TRACE4" = plus ]; then
    [[ -e /etc/wireguard/info.log || -e /etc/wireguard/info-temp.log ]] && PLUS4=' Teams' && grep -sq 'Device name' /etc/wireguard/info.log && PLUS4='+'
  fi
  [[ "$TRACE4" =~ on|plus ]] && WARPSTATUS4="( WARP$PLUS4 IPv4 )"
}

ip6_info() {
  unset IP6 COUNTRY6 ASNORG6 TRACE6 PLUS6 WARPSTATUS6
  IP6=$(curl -ks6m8 -A Mozilla $IP_API)
  WAN6=$(expr "$IP6" : '.*ip\":[ ]*\"\([^"]*\).*')
  COUNTRY6=$(expr "$IP6" : '.*country\":[ ]*\"\([^"]*\).*')
  ASNORG6=$(expr "$IP6" : '.*'$ISP'\":[ ]*\"\([^"]*\).*')
  TRACE6=$(curl -ks6m8 https://www.cloudflare.com/cdn-cgi/trace | grep warp | sed "s/warp=//g")
  if [ "$TRACE6" = plus ]; then
    [[ -e /etc/wireguard/info.log || -e /etc/wireguard/info-temp.log ]] && PLUS6=' Teams' && grep -sq 'Device name' /etc/wireguard/info.log && PLUS6='+'
  fi
  [[ "$TRACE6" =~ on|plus ]] && WARPSTATUS6="( WARP$PLUS6 IPv6 )"
}

# 检测 Client 是否开启，free 还是 Plus 账户 和 IP 信息
proxy_info() {
  unset PROXYSOCKS5 PROXYPORT PROXYJASON PROXYIP PROXYCOUNTR PROXYASNORG ACCOUNT QUOTA AC PROXYSOCKS52 PROXYPORT2 PROXYJASON2 PROXYIP2 PROXYCOUNTR2 PROXYASNORG2 ACCOUNT2 AC2 TRACE42

  if [ $(type -p warp-cli) ]; then
    PROXYSOCKS5=$(ss -nltp | grep 'warp' | awk '{print $(NF-2)}')
    PROXYPORT=$(echo "$PROXYSOCKS5" | cut -d: -f2)
    PROXYJASON=$(curl -sx socks5h://localhost:$PROXYPORT -A Mozilla $IP_API)
    PROXYIP=$(expr "$PROXYJASON" : '.*ip\":[ ]*\"\([^"]*\).*')
    PROXYCOUNTRY=$(expr "$PROXYJASON" : '.*country\":[ ]*\"\([^"]*\).*')
    [ "$L" = C ] && PROXYCOUNTRY=$(translate "$PROXYCOUNTRY")
    PROXYASNORG=$(expr "$PROXYJASON" : '.*'$ISP'\":[ ]*\"\([^"]*\).*')
    ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null)
    [[ "$ACCOUNT" =~ Limited ]] && AC='+' && check_quota
  fi

  if [ $(type -p wireproxy) ]; then
    PROXYSOCKS52=$(ss -nltp | grep 'wireproxy' | awk '{print $(NF-2)}')
    PROXYPORT2=$(echo "$PROXYSOCKS52" | cut -d: -f2)
    PROXYJASON2=$(curl -sx socks5h://localhost:$PROXYPORT2 -A Mozilla $IP_API)
    PROXYIP2=$(expr "$PROXYJASON2" : '.*ip\":[ ]*\"\([^"]*\).*')
    PROXYCOUNTRY2=$(expr "$PROXYJASON2" : '.*country\":[ ]*\"\([^"]*\).*')
    [ "$L" = C ] && PROXYCOUNTRY2=$(translate "$PROXYCOUNTRY2")
    PROXYASNORG2=$(expr "$PROXYJASON2" : '.*'$ISP'\":[ ]*\"\([^"]*\).*')
    TRACE42=$(eval echo "\$(curl -sx socks5h://localhost:$(ss -nltp | grep wireproxy | awk '{print $(NF-2)}'  | cut -d: -f2) https://www.cloudflare.com/cdn-cgi/trace)")
    AC2=' free' && [[ "$TRACE42" =~ plus ]] && [ -e /etc/wireguard/info.log ] && AC2=' Teams' && grep -sq 'Device name' /etc/wireguard/info.log && AC2='+' && check_quota
  fi
}

# 帮助说明
help() { hint " $(text 6) "; }

# 刷 WARP+ 流量
input() {
  reading " $(text 52) " ID
  i=5
  until [[ "$ID" =~ ^[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}$ ]]; do
    (( i-- )) || true
    [ "$i" = 0 ] && error " $(text 29) " || reading " $(text_eval 53) " ID
  done
}

plus() {
  echo -e "\n==============================================================\n"
  info " $(text 54) "
  echo -e "\n==============================================================\n"
  hint " $(text 55) "
  [ "$OPTION" != p ] && hint " 0. $(text 49) \n" || hint " 0. $(text 76) \n"
  reading " $(text 50) " CHOOSEPLUS
  case "$CHOOSEPLUS" in
    1 ) input
        [ $(type -p git) ] || ${PACKAGE_INSTALL[int]} git 2>/dev/null
        [ $(type -p python3) ] || ${PACKAGE_INSTALL[int]} python3 2>/dev/null
        [ -d ~/warp-plus-cloudflare ] || git clone https://github.com/aliilapro/warp-plus-cloudflare.git
        echo "$ID" | python3 ~/warp-plus-cloudflare/wp-plus.py ;;
    2 ) input
        reading " $(text 57) " MISSION
        MISSION=${MISSION//[^0-9]/}
        bash <(wget --no-check-certificate -qO- -T8 https://raw.githubusercontent.com/fscarmen/tools/main/warp_plus.sh) $MISSION $ID ;;
    3 ) input
        reading " $(text 57) " MISSION
        MISSION=${MISSION//[^0-9]/}
        bash <(wget --no-check-certificate -qO- -T8 https://raw.githubusercontent.com/SoftCreatR/warp-up/main/warp-up.sh) --disclaimer --id $ID --iterations $MISSION ;;
    0 ) [ "$OPTION" != p ] && menu || exit ;;
    * ) warning " $(text 51) [0-3] "; sleep 1; plus ;;
  esac
}

# IPv4 / IPv6 优先设置
stack_priority() {
  [ "$OPTION" = s ] && case "$PRIORITY_SWITCH" in
    4 ) PRIORITY=1 ;;
    6 ) PRIORITY=2 ;;
    d ) : ;;
    * ) hint "\n $(text 105) \n" && reading " $(text 50) " PRIORITY ;;
  esac

  [ -e /etc/gai.conf ] && sed -i '/^precedence \:\:ffff\:0\:0/d;/^label 2002\:\:\/16/d' /etc/gai.conf
  case "$PRIORITY" in
    1 ) echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf ;;
    2 ) echo "label 2002::/16   2" >> /etc/gai.conf ;;
  esac
}

# IPv4 / IPv6 优先结果
result_priority() {
  PRIO=(0 0)
  if [ -e /etc/gai.conf ]; then
    grep -qsE "^precedence[ ]+::ffff:0:0/96[ ]+100" /etc/gai.conf && PRIO[0]=1
    grep -qsE "^label[ ]+2002::/16[ ]+2" /etc/gai.conf && PRIO[1]=1
  fi
  case "${PRIO[*]}" in
    '1 0' ) PRIO=4 ;;
    '0 1' ) PRIO=6 ;;
    * ) [[ "$(curl -ksm8 -A Mozilla $IP_API | grep '"ip"' | sed 's/.*ip\":[ ]*\"\([^"]*\).*/\1/g')" =~ ^([0-9]{1,3}\.){3} ]] && PRIO=4 || PRIO=6 ;;
  esac
  PRIORITY_NOW=$(text_eval 97)

  # 如是快捷方式切换优先级别的话，显示结果
  [ "$OPTION" = s ] && hint "\n $PRIORITY_NOW \n"
}

# 更换 Netflix IP 时确认期望区域  
input_region() {
  [ -n "$NF" ] && REGION=$(tr 'a-z' 'A-Z' <<< "$(curl --user-agent "${UA_Browser}" -$NF -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/$REGION_TITLE" | sed 's/.*com\/\([^-/]\{1,\}\).*/\1/g')")
  [ -n "$PROXYPORT" ] && REGION=$(tr 'a-z' 'A-Z' <<< "$(curl --user-agent "${UA_Browser}" -sx socks5h://localhost:$PROXYPORT -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/$REGION_TITLE" | sed 's/.*com\/\([^-/]\{1,\}\).*/\1/g')")
  [ -n "$INTERFACE" ] && REGION=$(tr 'a-z' 'A-Z' <<< "$(curl --user-agent "${UA_Browser}" $INTERFACE -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/$REGION_TITLE" | sed 's/.*com\/\([^-/]\{1,\}\).*/\1/g')")
  REGION=${REGION:-'US'}
  reading " $(text_eval 56) " EXPECT
  until [[ -z "$EXPECT" || "$EXPECT" = [Yy] || "$EXPECT" =~ ^[A-Za-z]{2}$ ]]; do
    reading " $(text_eval 56) " EXPECT
  done
  [[ -z "$EXPECT" || "$EXPECT" = [Yy] ]] && EXPECT="$REGION"
}

# 更换支持 Netflix WARP IP 改编自 [luoxue-bot] 的成熟作品，地址[https://github.com/luoxue-bot/warp_auto_change_ip]
change_ip() {
  change_wgcf() {
    wgcf_restart() { warning " $(text_eval 126) " && ${SYSTEMCTL_RESTART[int]}; ss -nltp | grep dnsmasq >/dev/null 2>&1 && systemctl restart dnsmasq >/dev/null 2>&1; sleep $j; }
    unset T4 T6
    grep -q "^#.*0\.\0\/0" /etc/wireguard/wgcf.conf && T4=0 || T4=1
    grep -q "^#.*\:\:\/0" /etc/wireguard/wgcf.conf && T6=0 || T6=1
    case "$T4$T6" in
      01 ) NF='6' ;;
      10 ) NF='4' ;;
      11 ) hint "\n $(text 124) \n" && reading " $(text 50) " NETFLIX
           NF='4' && [ "$NETFLIX" = 2 ] && NF='6' ;;
    esac

    [ -z "$EXPECT" ] && input_region
    i=0; j=5
    while true; do
      (( i++ )) || true
      ip_now=$(date +%s); RUNTIME=$((ip_now - ip_start)); DAY=$(( RUNTIME / 86400 )); HOUR=$(( (RUNTIME % 86400 ) / 3600 )); MIN=$(( (RUNTIME % 86400 % 3600) / 60 )); SEC=$(( RUNTIME % 86400 % 3600 % 60 ))
      ip${NF}_info
      WAN=$(eval echo \$WAN$NF) && ASNORG=$(eval echo \$ASNORG$NF)
      [ "$L" = C ] && COUNTRY=$(translate "$(eval echo \$COUNTRY$NF)") || COUNTRY=$(eval echo \$COUNTRY$NF)
      RESULT=$(curl --user-agent "${UA_Browser}" -$NF -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/$RESULT_TITLE"  2>&1)
      if [ "$RESULT" = 200 ]; then
        REGION=$(tr 'a-z' 'A-Z' <<< $(curl --user-agent "${UA_Browser}" -"$NF" -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/$REGION_TITLE" | sed 's/.*com\/\([^-/]\{1,\}\).*/\1/g'))
        REGION=${REGION:-'US'}
        echo "$REGION" | grep -qi "$EXPECT" && info " $(text_eval 125) " && i=0 && sleep 1h || wgcf_restart
      else
        wgcf_restart
      fi
    done
  }

  change_client() {
    client_restart() {
      [[ $(warp-cli --accept-tos settings) =~ WarpProxy ]] && CLIENT_PROXY=1
      warning " $(text_eval 126) " && warp-cli --accept-tos delete >/dev/null 2>&1
      [ "$CLIENT_PROXY" != 1 ] && rule_del >/dev/null 2>&1
      warp-cli --accept-tos register >/dev/null 2>&1 &&
      [ -e /etc/wireguard/license ] && warp-cli --accept-tos set-license $(cat /etc/wireguard/license) >/dev/null 2>&1
      sleep $j
      [ "$CLIENT_PROXY" != 1 ] && rule_add >/dev/null 2>&1
    }

    if [[ $(warp-cli --accept-tos settings) =~ WarpProxy ]]; then
      PROXYPORT="$(ss -nltp | grep 'warp' | awk '{print $(NF-2)}'  | cut -d: -f2)"
      [ -z "$EXPECT" ] && input_region
      i=0; j=10
      while true; do
        (( i++ )) || true
        ip_now=$(date +%s); RUNTIME=$((ip_now - ip_start)); DAY=$(( RUNTIME / 86400 )); HOUR=$(( (RUNTIME % 86400 ) / 3600 )); MIN=$(( (RUNTIME % 86400 % 3600) / 60 )); SEC=$(( RUNTIME %86400 % 3600 % 60 ))
        proxy_info
        WAN=$PROXYIP && ASNORG=$PROXYASNORG && NF=4 && COUNTRY=$PROXYCOUNTRY
        RESULT=$(curl --user-agent "${UA_Browser}" -sx socks5h://localhost:$PROXYPORT -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/$RESULT_TITLE"  2>&1)
        if [ "$RESULT" = 200 ]; then
          REGION=$(tr 'a-z' 'A-Z' <<< $(curl --user-agent "${UA_Browser}" -sx socks5h://localhost:$PROXYPORT -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/$REGION_TITLE" | sed 's/.*com\/\([^-/]\{1,\}\).*/\1/g'))
          REGION=${REGION:-'US'}
          echo "$REGION" | grep -qi "$EXPECT" && info " $(text_eval 125) " && i=0 && sleep 1h || client_restart
        else
          client_restart
        fi
      done

    else
      INTERFACE='--interface CloudflareWARP'
      [ -z "$EXPECT" ] && input_region
      i=0; j=10
      while true; do
        (( i++ )) || true
        ip_now=$(date +%s); RUNTIME=$((ip_now - ip_start)); DAY=$(( RUNTIME / 86400 )); HOUR=$(( (RUNTIME % 86400 ) / 3600 )); MIN=$(( (RUNTIME % 86400 % 3600) / 60 )); SEC=$(( RUNTIME % 86400 % 3600 % 60 ))
        ip4_info
        WAN=$WAN4 && ASNORG=$ASNORG4 && NF=4
        [ "$L" = C ] && COUNTRY=$(translate "$COUNTRY4") || COUNTRY=$COUNTRY4
        RESULT=$(curl --user-agent "${UA_Browser}" $INTERFACE -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/$RESULT_TITLE"  2>&1)
        if [ "$RESULT" = 200 ]; then
          REGION=$(tr 'a-z' 'A-Z' <<< $(curl --user-agent "${UA_Browser}" $INTERFACE -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/$REGION_TITLE" | sed 's/.*com\/\([^-/]\{1,\}\).*/\1/g'))
          REGION=${REGION:-'US'}
          echo "$REGION" | grep -qi "$EXPECT" && info " $(text_eval 125) " && i=0 && sleep 1h || client_restart
        else
          client_restart
        fi
      done
    fi
  }

  change_wireproxy() {
    wireproxy_restart() { warning " $(text_eval 126) " && systemctl restart wireproxy; sleep $j; }

    PROXYPORT="$(ss -nltp | grep 'wireproxy' | awk '{print $(NF-2)}'  | cut -d: -f2)"
    [ -z "$EXPECT" ] && input_region
    i=0; j=5
    while true; do
      (( i++ )) || true
      ip_now=$(date +%s); RUNTIME=$((ip_now - ip_start)); DAY=$(( RUNTIME / 86400 )); HOUR=$(( (RUNTIME % 86400 ) / 3600 )); MIN=$(( (RUNTIME % 86400 % 3600) / 60 )); SEC=$(( RUNTIME % 86400 % 3600 % 60 ))
      proxy_info
      WAN=$PROXYIP2 && ASNORG=$PROXYASNORG2 && COUNTRY=$PROXYCOUNTRY2
      RESULT=$(curl --user-agent "${UA_Browser}" -sx socks5h://localhost:$PROXYPORT -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/$RESULT_TITLE"  2>&1)
      if [ "$RESULT" = 200 ]; then
        REGION=$(tr 'a-z' 'A-Z' <<< $(curl --user-agent "${UA_Browser}" -sx socks5h://localhost:$PROXYPORT -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/$REGION_TITLE" | sed 's/.*com\/\([^-/]\{1,\}\).*/\1/g'))
        REGION=${REGION:-'US'}
        echo "$REGION" | grep -qi "$EXPECT" && info " $(text_eval 125) " && i=0 && sleep 1h || wireproxy_restart
      else
        wireproxy_restart
      fi
    done
  }

  # 设置时区，让时间戳时间准确，显示脚本运行时长，中文为 GMT+8，英文为 UTC; 设置 UA
  ip_start=$(date +%s)
  [ "$SYSTEM" != Alpine ] && ( [ "$L" = C ] && timedatectl set-timezone Asia/Shanghai || timedatectl set-timezone UTC )
  UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"

  # 根据 lmc999 脚本检测 Netflix Title，如获取不到，使用兜底默认值
  LMC999=$(curl -sSLm4 https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
  RESULT_TITLE=$(echo "$LMC999" | grep "result.*netflix.com/title/" | sed "s/.*title\/\([^\"]*\).*/\1/")
  REGION_TITLE=$(echo "$LMC999" | grep "region.*netflix.com/title/" | sed "s/.*title\/\([^\"]*\).*/\1/")
  RESULT_TITLE=${RESULT_TITLE:-'80062035'}; REGION_TITLE=${REGION_TITLE:-'80018499'}

  # 根据 WARP interface 、 Client 和 WirePorxy 的安装情况判断刷 IP 的方式
  INSTALL_CHECK=("wg-quick" "warp-cli" "wireproxy")
  CASE_RESAULT=("0 0 0" "0 0 1" "0 1 0" "0 1 1" "1 0 0" "1 0 1" "1 1 0" "1 1 1")
  SHOW_CHOOSE=("$(text 150)" "" "" "$(text 151)" "" "$(text 152)" "$(text 153)" "$(text 154)")
  CHANGE_IP1=("" "change_wireproxy" "change_client" "change_client" "change_wgcf" "change_wgcf" "change_wgcf" "change_wgcf")
  CHANGE_IP2=("" "" "" "change_wireproxy" "" "change_wireproxy" "change_client" "change_client")
  CHANGE_IP3=("" "" "" "" "" "" "" "change_wireproxy")

  for ((a=0; a<${#INSTALL_CHECK[@]}; a++)); do
    [ $(type -p ${INSTALL_CHECK[a]}) ] && INSTALL_RESULT[a]=1 || INSTALL_RESULT[a]=0
  done

  for ((b=0; b<${#CASE_RESAULT[@]}; b++)); do
    [[ "${INSTALL_RESULT[@]}" = "${CASE_RESAULT[b]}" ]] && break
  done

  case "$b" in
    0 ) error " $(text 150) " ;;
    1|2|4 ) ${CHANGE_IP1[b]} ;;
    * ) hint "\n ${SHOW_CHOOSE[b]} \n" && reading " $(text 50) " MODE
        case "$MODE" in
          [1-3] ) $(eval echo "\${CHANGE_IP$MODE[b]}") ;;
          * ) warning " $(text 51) [1-3] "; sleep 1; change_ip ;;
        esac ;;
  esac
}

# 安装BBR
bbrInstall() {
  echo -e "\n==============================================================\n"
  info " $(text 47) "
  echo -e "\n==============================================================\n"
  hint " 1. $(text 48) "
  [ "$OPTION" != b ] && hint " 0. $(text 49) \n" || hint " 0. $(text 76) \n"
  reading " $(text 50) " BBR
  case "$BBR" in
    1 ) wget --no-check-certificate -N "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh ;;
    0 ) [ "$OPTION" != b ] && menu || exit ;;
    * ) warning " $(text 51) [0-1]"; sleep 1; bbrInstall ;;
  esac
}

# 关闭 WARP 网络接口，并删除 WGCF
uninstall() {
  unset IP4 IP6 WAN4 WAN6 COUNTRY4 COUNTRY6 ASNORG4 ASNORG6
  # 卸载 WGCF
  uninstall_wgcf() {
    wg-quick down wgcf >/dev/null 2>&1
    systemctl disable --now wg-quick@wgcf >/dev/null 2>&1
    [ $(type -p rpm) ] && rpm -e wireguard-tools 2>/dev/null
    systemctl restart systemd-resolved >/dev/null 2>&1 && sleep 5
    systemctl enable --now systemd-resolved >/dev/null 2>&1
    rm -rf /usr/bin/wgcf /etc/wireguard /usr/bin/wireguard-go /usr/bin/warp /etc/dnsmasq.d/warp.conf /usr/bin/wireproxy /etc/local.d/wgcf.start
    [ -e /etc/gai.conf ] && sed -i '/^precedence \:\:ffff\:0\:0/d;/^label 2002\:\:\/16/d' /etc/gai.conf
    [ -e /usr/bin/tun.sh ] && rm -f /usr/bin/tun.sh
    [ -e /etc/crontab ] && sed -i '/tun.sh/d' /etc/crontab
    sed -i "/250   warp/d" /etc/iproute2/rt_tables
  }

  # 卸载 Linux Client
  uninstall_proxy() {
    warp-cli --accept-tos disconnect >/dev/null 2>&1
    warp-cli --accept-tos disable-always-on >/dev/null 2>&1
    warp-cli --accept-tos delete >/dev/null 2>&1
    rule_del >/dev/null 2>&1
    ${PACKAGE_UNINSTALL[int]} cloudflare-warp 2>/dev/null
    systemctl disable --now warp-svc >/dev/null 2>&1
    rm -rf /usr/bin/wgcf /etc/wireguard /usr/bin/wireguard-go /usr/bin/warp
  }

  # 卸载 WirePorxy
  uninstall_wireproxy() {
    systemctl disable --now wireproxy
    rm -rf /usr/bin/wgcf /etc/wireguard /usr/bin/wireguard-go /usr/bin/warp /etc/dnsmasq.d/warp.conf /usr/bin/wireproxy /lib/systemd/system/wireproxy.service
    [ -e /etc/gai.conf ] && sed -i '/^precedence \:\:ffff\:0\:0/d;/^label 2002\:\:\/16/d' /etc/gai.conf
    [ -e /usr/bin/tun.sh ] && rm -f /usr/bin/tun.sh && sed -i '/tun.sh/d' /etc/crontab
  }

  # 如已安装 warp_unlock 项目，先行卸载
  [ -e /etc/wireguard/warp_unlock.sh ] && bash <(curl -sSL https://raw.githubusercontent.com/fscarmen/warp_unlock/main/unlock.sh) -U -$L

  # 根据已安装情况执行卸载任务并显示结果
  UNINSTALL_CHECK=("wg-quick" "warp-cli" "wireproxy")
  UNINSTALL_DO=("uninstall_wgcf" "uninstall_proxy" "uninstall_wireproxy")
  UNINSTALL_DEPENDENCIES=("wireguard-tools openresolv " "" " openresolv ")
  UNINSTALL_NOT_ARCH=("wireguard-dkms " "" "wireguard-dkms resolvconf ")
  UNINSTALL_DNSMASQ=("ipset dnsmasq resolvconf ")
  UNINSTALL_RESULT=("$(text 117)" "$(text 119)" "$(text 98)")
  for ((i=0; i<${#UNINSTALL_CHECK[@]}; i++)); do
    [ $(type -p ${UNINSTALL_CHECK[i]}) ] && UNINSTALL_DO_LIST[i]=1 && UNINSTALL_DEPENDENCIES_LIST+=${UNINSTALL_DEPENDENCIES[i]}
    [[ $SYSTEM != "Arch" && $(dkms status 2>/dev/null) =~ wireguard ]] && UNINSTALL_DEPENDENCIES_LIST+=${UNINSTALL_NOT_ARCH[i]}
    [ -e /etc/dnsmasq.d/warp.conf ] && UNINSTALL_DEPENDENCIES_LIST+=${UNINSTALL_DNSMASQ[i]}
  done

  # 列出依赖，确认是手动还是自动卸载
  UNINSTALL_DEPENDENCIES_LIST=$(echo $UNINSTALL_DEPENDENCIES_LIST | sed "s/ /\n/g" | sort -u | paste -d " " -s)
  [ "$UNINSTALL_DEPENDENCIES_LIST" != '' ] && hint "\n $(text_eval 79) \n" && reading " $(text 170) " CONFIRM_UNINSTALL

  # 卸载核心程序
  for ((i=0; i<${#UNINSTALL_CHECK[@]}; i++)); do
    [[ "${UNINSTALL_DO_LIST[i]}" = 1 ]] && ( ${UNINSTALL_DO[i]}; info " ${UNINSTALL_RESULT[i]} " )
  done

  # 选择自动卸载依赖执行以下
  [[ "$UNINSTALL_DEPENDENCIES_LIST" != '' && "$CONFIRM_UNINSTALL" = [Yy] ]] && ( ${PACKAGE_UNINSTALL[int]} $UNINSTALL_DEPENDENCIES_LIST 2>/dev/null; info " $(text 171) \n" )

  # 显示卸载结果
  ip4_info; [[ "$L" = C && -n "$COUNTRY4" ]] && COUNTRY4=$(translate "$COUNTRY4")
  ip6_info; [[ "$L" = C && -n "$COUNTRY6" ]] && COUNTRY6=$(translate "$COUNTRY6")
  info " $(text 45)\n IPv4: $WAN4 $COUNTRY4 $ASNORG4\n IPv6: $WAN6 $COUNTRY6 $ASNORG6 "
}
        
# 同步脚本至最新版本
ver() {
  wget -N -P /etc/wireguard https://raw.githubusercontent.com/fscarmen/warp/main/menu.sh || error " $(text 65) "
  chmod +x /etc/wireguard/menu.sh
  ln -sf /etc/wireguard/menu.sh /usr/bin/warp
  info " $(text 64):$(grep ^VERSION /etc/wireguard/menu.sh | sed "s/.*=//g")  $(text 18):$(grep "${L}\[1\]" /etc/wireguard/menu.sh | cut -d \" -f2) "
  exit
}

# 由于warp bug，有时候获取不了ip地址，加入刷网络脚本手动运行，并在定时任务加设置 VPS 重启后自动运行,i=当前尝试次数，j=要尝试的次数
net() {
  unset IP4 IP6 WAN4 WAN6 COUNTRY4 COUNTRY6 ASNORG4 ASNORG6 WARPSTATUS4 WARPSTATUS6 TYPE
  [[ ! $(type -p wg-quick) || ! -e /etc/wireguard/wgcf.conf ]] && error " $(text 10) "
  i=1; j=5
  hint " $(text_eval 11)\n $(text_eval 12) "
  [ "$SYSTEM" != Alpine ] && [[ $(systemctl is-active wg-quick@wgcf) != 'active' ]] && wg-quick down wgcf >/dev/null 2>&1
  ${SYSTEMCTL_START[int]} >/dev/null 2>&1
  wg-quick up wgcf >/dev/null 2>&1
  ss -nltp | grep dnsmasq >/dev/null 2>&1 && systemctl restart dnsmasq >/dev/null 2>&1
  ip4_info; ip6_info
  until [[ "$TRACE4$TRACE6" =~ on|plus ]]; do
    (( i++ )) || true
    hint " $(text_eval 12) "
    ${SYSTEMCTL_RESTART[int]} >/dev/null 2>&1
    ss -nltp | grep dnsmasq >/dev/null 2>&1 && systemctl restart dnsmasq >/dev/null 2>&1
    ip4_info; ip6_info
    if [[ "$i" = "$j" ]]; then
        if [ "$CHOOSE_TYPE" = 3 ]; then
          unset CHOOSE_TYPE && i=0 && info " $(text 129) "
          mv -f /etc/wireguard/wgcf.conf.bak /etc/wireguard/wgcf.conf
          rm -f /etc/wireguard/info-temp.log
        else
          wg-quick down wgcf >/dev/null 2>&1
          error " $(text_eval 13) "
        fi
    fi
  done

  # 判断账户类型，如果是 plus，检测剩余流量
  [ -e /etc/wireguard/info.log ] && TYPE=' Teams' && grep -sq 'Device name' /etc/wireguard/info.log && TYPE='+' && check_quota

  info " $(text_eval 14) "
  [ "$L" = C ] && COUNTRY4=$(translate "$COUNTRY4")
  [ "$L" = C ] && COUNTRY6=$(translate "$COUNTRY6")
  [[ $OPTION = [on] ]] && info " IPv4:$WAN4 $WARPSTATUS4 $COUNTRY4 $ASNORG4\n IPv6:$WAN6 $WARPSTATUS6 $COUNTRY6 $ASNORG6 "
}

# WARP 开关，先检查是否已安装，再根据当前状态转向相反状态
onoff() { 
  [ ! $(type -p wg-quick) ] && error " $(text 155) "
  [ -n "$(wg 2>/dev/null)" ] && (wg-quick down wgcf >/dev/null 2>&1; info " $(text 15) ") || net
}

# Proxy 开关，先检查是否已安装，再根据当前状态转向相反状态
proxy_onoff() {
  [ ! $(type -p warp-cli) ] && error " $(text 93) "
  if systemctl is-active warp-svc >/dev/null 2>&1; then
    [[ ! "$(warp-cli --accept-tos settings)" =~ WarpProxy ]] && rule_del >/dev/null 2>&1
    systemctl stop warp-svc
    info " $(text 91) " && exit 0

  else  systemctl start warp-svc; sleep 2
    if [[ $(warp-cli --accept-tos settings) =~ WarpProxy ]]; then
      proxy_info
      ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null)
      [[ $ACCOUNT =~ Limited ]] && AC='+' && CHECK_TYPE=1 && check_quota
      [[ $(ss -nltp) =~ warp-svc ]] && info " $(text 90)\n $(text 27): $PROXYSOCKS5\n WARP$AC IPv4: $PROXYIP $PROXYCOUNTRY $PROXYASNORG "
      [ -n "$QUOTA" ] && info " $(text 63): $QUOTA "
      exit 0

    else INTERFACE='--interface CloudflareWARP'
      rule_add >/dev/null 2>&1
      ip4_info
      [[ "$L" = C && -n "$COUNTRY4" ]] && COUNTRY4=$(translate "$COUNTRY4")
      ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null)
      [[ $ACCOUNT =~ Limited ]] && AC='+' && CHECK_TYPE=1 && check_quota
      [[ $(ip a) =~ CloudflareWARP ]] && info " $(text 90)\n $(text_eval 169) "
      [ -n "$QUOTA" ] && info " $(text 63): $QUOTA "
      exit 0
    fi
  fi
}

# WireProxy 开关，先检查是否已安装，再根据当前状态转向相反状态
wireproxy_onoff() {
  unset QUOTA
  [ ! $(type -p wireproxy) ] && error " $(text 157) " || OCTEEP=1
  if ss -nltp | grep wireproxy >/dev/null 2>&1; then
    systemctl stop wireproxy
    [[ ! $(ss -nltp) =~ wireproxy ]] && info " $(text 158) "
  else
    systemctl start wireproxy
    sleep 1 && proxy_info
    [[ $(ss -nltp) =~ wireproxy ]] && info " $(text 99)\n $(text 27): $PROXYSOCKS52\n WARP$AC2 IPv4: $PROXYIP2 $PROXYCOUNTRY2 $PROXYASNORG2 "
    [ -n "$QUOTA" ] && info " $(text 25): $(grep 'Device name' /etc/wireguard/info.log | awk '{ print $NF }')\n $(text 63): $QUOTA "
  fi
}

# 检查系统 WARP 单双栈情况。为了速度，先检查 WGCF 配置文件里的情况，再判断 trace
check_stack() {
  if [ -e /etc/wireguard/wgcf.conf ]; then
    grep -q "^#.*0\.\0\/0" /etc/wireguard/wgcf.conf && T4=0 || T4=1
    grep -q "^#.*\:\:\/0" /etc/wireguard/wgcf.conf && T6=0 || T6=1
  else
    case "$TRACE4" in off ) T4='0' ;; 'on'|'plus' ) T4='1' ;; esac
    case "$TRACE6" in off ) T6='0' ;; 'on'|'plus' ) T6='1' ;; esac
  fi
  CASE=("@0" "0@" "0@0" "@1" "0@1" "1@" "1@0" "1@1")
  for ((m=0;m<${#CASE[@]};m++)); do [ "$T4"@"$T6" = "${CASE[m]}" ] && break; done
  WARP_BEFORE=("" "" "" "WARP IPv6 only" "WARP IPv6" "WARP IPv4 only" "WARP IPv4" "$(text 70)")
  WARP_AFTER1=("" "" "" "WARP IPv4" "WARP IPv4" "WARP IPv6" "WARP IPv6" "WARP IPv4")
  WARP_AFTER2=("" "" "" "$(text 70)" "$(text 70)" "$(text 70)" "$(text 70)" "WARP IPv6")
  TO1=("" "" "" "014" "014" "106" "106" "114")
  TO2=("" "" "" "01D" "01D" "10D" "10D" "116")
  SHORTCUT1=("" "" "" "(warp 4)" "(warp 4)" "(warp 6)" "(warp 6)" "(warp 4)")
  SHORTCUT2=("" "" "" "(warp d)" "(warp d)" "(warp d)" "(warp d)" "(warp 6)")

  # 判断用于检测 NAT VSP，以选择正确配置文件
  if [ "$m" -le 3 ]; then
    NAT=("0@1@" "1@0@1" "1@1@1" "0@1@1")
    for ((n=0;n<${#NAT[@]};n++)); do [ "$IPV4@$IPV6@$INET4" = "${NAT[n]}" ] && break; done
    NATIVE=("IPv6 only" "IPv4 only" "$(text 69)" "NAT IPv4")
    CONF1=("014" "104" "114" "11N4")
    CONF2=("016" "106" "116" "11N6")
    CONF3=("01D" "10D" "11D" "11ND")
  fi
}

# 单双栈在线互换。先看菜单是否有选择，再看传参数值，再没有显示2个可选项
stack_switch() {
  # WARP 单双栈切换选项
  SWITCH014='sed -i "s/#//g;s/^.*\:\:\/0/#&/g" /etc/wireguard/wgcf.conf'
  SWITCH01D='sed -i "s/#//g" /etc/wireguard/wgcf.conf'
  SWITCH106='sed -i "s/#//g;s/^.*0\.\0\/0/#&/g" /etc/wireguard/wgcf.conf'
  SWITCH10D='sed -i "s/#//g" /etc/wireguard/wgcf.conf'
  SWITCH114='sed -i "s/^.*\:\:\/0/#&/g" /etc/wireguard/wgcf.conf'
  SWITCH116='sed -i "s/^.*0\.\0\/0/#&/g" /etc/wireguard/wgcf.conf'

  [[ "$CLIENT" = [35] && "$SWITCHCHOOSE" = [4D] ]] && error " $(text 109) "
  check_stack
  if [[ "$CHOOSE1" = [12] ]]; then
    TO=$(eval echo "\${TO$CHOOSE1[m]}")
  elif [[ "$SWITCHCHOOSE" = [46D] ]]; then
    [[ "$T4@$T6@$SWITCHCHOOSE" =~ '1@0@4'|'0@1@6'|'1@1@D' ]] && error " $(text 146) " || TO="$T4$T6$SWITCHCHOOSE"
  fi
  [ "${#TO}" != 3 ] && error " $(text 172) " || sh -c "$(eval echo "\$SWITCH$TO")"
  ${SYSTEMCTL_RESTART[int]}; sleep 1
  OPTION=n && net
}

# 检测系统信息
check_system_info() {
  info " $(text 37) "

  # 判断 LXC、 KVM 的 Linux 版本是否小于 5.6，如是则安装 wireguard 内核模块，变量 WG=1。由于 linux 不能直接用小数作比较，所以用 （主版本号 * 100 + 次版本号 ）与 506 作比较
  [[ $(($(uname -r | cut -d . -f1) * 100 +  $(uname -r | cut -d . -f2))) -lt 506 ]] && WG=1

  # 必须加载 TUN 模块，先尝试在线打开 TUN。尝试成功放到启动项，失败作提示并退出脚本
  if [ "$WG" = 1 ]; then
    TUN=$(cat /dev/net/tun 2>&1 | tr 'A-Z' 'a-z')
    if [[ ! "$TUN" =~ 'in bad state' ]] && [[ ! "$TUN" =~ '处于错误状态' ]] && [[ ! "$TUN" =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
      cat >/usr/bin/tun.sh << EOF
#!/usr/bin/env bash
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 0666 /dev/net/tun
EOF
      bash /usr/bin/tun.sh
      TUN=$(cat /dev/net/tun 2>&1 | tr 'A-Z' 'a-z')
      if [[ ! "$TUN" =~ 'in bad state' ]] && [[ ! "$TUN" =~ '处于错误状态' ]] && [[ ! "$TUN" =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
        rm -f /usr/bin/tun.sh && error " $(text 3) "
      else
        chmod +x /usr/bin/tun.sh
        [ "$SYSTEM" != Alpine ] && echo "@reboot root bash /usr/bin/tun.sh" >> /etc/crontab
      fi
    fi
  fi

  # 判断机器原生状态类型
  IPV4=0; IPV6=0
  LAN4=$(ip route get 192.168.193.10 2>/dev/null | awk '{for (i=0; i<NF; i++) if ($i=="src") {print $(i+1)}}')
  LAN6=$(ip route get 2606:4700:d0::a29f:c001 2>/dev/null | awk '{for (i=0; i<NF; i++) if ($i=="src") {print $(i+1)}}')
  [[ "$LAN6" != "::1" && "$LAN6" =~ ^([a-f0-9]{1,4}:){2,4}[a-f0-9]{1,4} ]] && INET6=1 && $PING6 -c2 -w10 2606:4700:d0::a29f:c001 >/dev/null 2>&1 && IPV6=1 && CDN=-6 && ip6_info
  [[ "$LAN4" =~ ^([0-9]{1,3}\.){3} ]] && INET4=1 && ping -c2 -W3 162.159.193.10 >/dev/null 2>&1 && IPV4=1 && CDN=-4 && ip4_info
  [[ "$L" = C && -n "$COUNTRY4" ]] && COUNTRY4=$(translate "$COUNTRY4")
  [[ "$L" = C && -n "$COUNTRY6" ]] && COUNTRY6=$(translate "$COUNTRY6")

  # 判断当前 WARP 状态，决定变量 PLAN，变量 PLAN 含义:1=单栈  2=双栈  3=WARP已开启
  [[ "$TRACE4$TRACE6" =~ on|plus ]] && PLAN=3 || PLAN=$((IPV4+IPV6))

  # 判断处理器架构
  case $(uname -m) in
    aarch64 ) ARCHITECTURE=arm64; AMD64_ONLY="$(text 156)" ;;
    x86_64 ) ARCHITECTURE=amd64 ;;
    s390x ) ARCHITECTURE=s390x; AMD64_ONLY="$(text 156)" ;;
    * ) error " $(text_eval 134) " ;;
  esac

  # 判断当前 Linux Client 状态，决定变量 CLIENT，变量 CLIENT 含义:0=未安装  1=已安装未激活  2=状态激活  3=Clinet proxy 已开启  5=Clinet warp 已开启
  CLIENT=0
  if [ $(type -p warp-cli) ]; then
    ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null)
    [[ $ACCOUNT =~ Limited ]] && CHECK_TYPE=1 && AC='+' && check_quota
    CLIENT=1 && CLIENT_INSTALLED="$(text 92)"
    [[ $(systemctl is-active warp-svc 2>/dev/null) = active || $(systemctl is-enabled warp-svc 2>/dev/null) = enabled ]] && CLIENT=2
    if [[ $(warp-cli --accept-tos settings) =~ WarpProxy ]]; then
      [ "$CLIENT" = 2 ] && CLIENT_MODE='Proxy' && [[ $(ss -nltp) =~ warp-svc ]] && CLIENT=3 && proxy_info
    else
      [ "$CLIENT" = 2 ] && CLIENT_MODE='WARP' && [[ $(ip a) =~ CloudflareWARP ]] && CLIENT=5 && INTERFACE='--interface CloudflareWARP' && ip4_info
    fi
  fi

  # 判断当前 WireProxy 状态，决定变量 WIREPROXY，变量 WIREPROXY 含义:0=未安装，1=已安装,断开状态，2=Clinet 已开启
  WIREPROXY=0
  if [ $(type -p wireproxy) ]; then
    WIREPROXY=1
    [ "$WIREPROXY" = 1 ] && WIREPROXY_INSTALLED="$(text 92)" && [[ $(ss -nltp) =~ wireproxy ]] && WIREPROXY=2 && proxy_info
  fi
}

rule_add() {
  ip -4 rule add from 172.16.0.2 lookup 51820
  ip -4 route add default dev CloudflareWARP table 51820
  ip -4 rule add table main suppress_prefixlength 0
}

rule_del() {
  ip -4 rule delete from 172.16.0.2 lookup 51820
  ip -4 rule delete table main suppress_prefixlength 0
}

# 替换为 Teams 账户信息
teams_change() {
  sed -i "s#PrivateKey.*#PrivateKey = $PRIVATEKEY#g;s#Address.*32#Address = ${ADDRESS4}/32#g;s#Address.*128#Address = ${ADDRESS6}/128#g;s#PublicKey.*#PublicKey = $PUBLICKEY#g" /etc/wireguard/wgcf.conf
  case $IPV4$IPV6 in
    01 ) sed -i "s#Endpoint.*#Endpoint = $(expr "$TEAMS" : '.*v6&quot;:&quot;\(.*]\):.*'):2408#g" /etc/wireguard/wgcf.conf ;;
    10 ) sed -i "s#Endpoint.*#Endpoint = $(expr "$TEAMS" : '.*v4&quot;:&quot;\(.*\):0&quot;,.*'):2408#g" /etc/wireguard/wgcf.conf ;;     
  esac
}
        
# 输入 WARP+ 账户（如有），限制位数为空或者26位以防输入错误
input_license() {
  [ -z "$LICENSE" ] && reading " $(text 28) " LICENSE
  i=5
  until [[ -z "$LICENSE" || "$LICENSE" =~ ^[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}$ ]]; do
    (( i-- )) || true
    [ "$i" = 0 ] && error " $(text 29) " || reading " $(text_eval 30) " LICENSE
  done
  if [ "$INPUT_LICENSE" = 1 ]; then
    [[ -n "$LICENSE" && -z "$NAME" ]] && reading " $(text 102) " NAME
    [[ -n "$NAME" ]] && NAME="${NAME//[[:space:]]/_}" || NAME=${NAME:-'WARP'}
  fi
}

# 输入 Teams 账户 URL（如有）
input_url() {
  [ -z "$URL" ] && reading " $(text 127) " URL
  URL=${URL:-'https://gist.githubusercontent.com/fscarmen/56aaf02d743551737c9973b8be7a3496/raw/61bf63e68e4e91152545679b8f11c72cac215128/2021.12.21'}
  TEAMS=$(curl -sSL "$URL" | sed "s/\"/\&quot;/g")
  PRIVATEKEY=$(expr "$TEAMS" : '.*private_key&quot;>\([^<]*\).*')
  PUBLICKEY=$(expr "$TEAMS" : '.*public_key&quot;:&quot;\([^&]*\).*')
  ADDRESS4=$(expr "$TEAMS" : '.*v4&quot;:&quot;\(172[^&]*\).*')
  ADDRESS6=$(expr "$TEAMS" : '.*v6&quot;:&quot;\([^[&]*\).*')
  [[ "$PRIVATEKEY" =~ ^[A-Z0-9a-z/+]{43}=$ ]] && MATCH1=$(text 135) || MATCH1=$(text 136)
  [[ "$PUBLICKEY" =~ ^[A-Z0-9a-z/+]{43}=$ ]] && MATCH2=$(text 135) || MATCH2=$(text 136)
  [[ "$ADDRESS4" =~ ^172.16.[01].[0-9]{1,3}$ ]] && MATCH3=$(text 135) || MATCH3=$(text 136)
  [[ "$ADDRESS6" =~ ^fd01(:[0-9a-f]{0,4}){7}$ ]] && MATCH4=$(text 135) || MATCH4=$(text 136)
  hint "\n $(text_eval 130) \n" && reading " $(text 131) " CONFIRM
}

# 升级 WARP+ 账户（如有），限制位数为空或者26位以防输入错误，WARP interface 可以自定义设备名(不允许字符串间有空格，如遇到将会以_代替)
update_license() {
  [ -z "$LICENSE" ] && reading " $(text 61) " LICENSE
  i=5
  until [[ "$LICENSE" =~ ^[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}$ ]]; do
    (( i-- )) || true
    [ "$i" = 0 ] && error " $(text 29) " || reading " $(text_eval 100) " LICENSE
  done
  [[ -z "$ACCOUNT" && "$CHOOSE_TYPE" = 2 && -n "$LICENSE" && -z "$NAME" ]] && reading " $(text 102) " NAME
  [ -n "$NAME" ] && NAME="${NAME//[[:space:]]/_}" || NAME=${NAME:-'WARP'}
}

# 输入 Linux Client 端口,先检查默认的40000是否被占用,限制4-5位数字,准确匹配空闲端口
input_port() {
  i=5
  PORT=40000
  ss -nltp | grep -q ":$PORT"[[:space:]] && reading " $(text_eval 103) " PORT || reading " $(text 104) " PORT
  PORT=${PORT:-'40000'}
  until grep -qE "^[1-9][0-9]{3,4}$" <<< $PORT && [[ "$PORT" -ge 1000 && "$PORT" -le 65535 ]] && [[ ! $(ss -nltp) =~ :"$PORT"[[:space:]] ]]; do
    (( i-- )) || true
    [ "$i" = 0 ] && error " $(text 29) "
    if grep -qwE "^[1-9][0-9]{3,4}$" <<< $PORT; then
      if [[ "$PORT" -ge 1000 && "$PORT" -le 65535 ]]; then
        [[ $(ss -nltp) =~ :"$PORT"[[:space:]] ]] && reading " $(text_eval 103) " PORT
      else
        reading " $(text_eval 111) " PORT
        PORT=${PORT:-'40000'}
      fi
    else
      reading " $(text_eval 111) " PORT
      PORT=${PORT:-'40000'}
    fi    
  done
}

# Linux Client 或 WireProxy 端口
change_port() {
  socks5_port() { input_port; warp-cli --accept-tos set-proxy-port "$PORT"; }
  wireproxy_port() {
    input_port
    sed -i "s/BindAddress.*/BindAddress = 127.0.0.1:$PORT/g" /etc/wireguard/proxy.conf
    systemctl restart wireproxy
  }

  INSTALL_CHECK=("$CLIENT" "$WIREPROXY")
  CASE_RESAULT=("0 1" "1 0" "1 1")
  SHOW_CHOOSE=("" "" "$(text 151)")
  CHANGE_PORT1=("wireproxy_port" "socks5_port" "socks5_port")
  CHANGE_PORT2=("" "" "wireproxy_port")

  for ((e=0;e<${#INSTALL_CHECK[@]}; e++)); do
    [[ "${INSTALL_CHECK[e]}" -gt 1 ]] && INSTALL_RESULT[e]=1 || INSTALL_RESULT[e]=0
  done

  for ((f=0; f<${#CASE_RESAULT[@]}; f++)); do
    [[ "${INSTALL_RESULT[@]}" = "${CASE_RESAULT[f]}" ]] && break
  done

  case "$f" in
    0|1 ) ${CHANGE_PORT1[f]}
          ss -nltp | grep -q ":$PORT" && info " $(text_eval 122) " || error " $(text 34) " ;;
    2 ) hint " ${SHOW_CHOOSE[f]} " && reading " $(text 50) " MODE
        case "$MODE" in
          [1-2] ) $(eval echo "\${CHANGE_IP$MODE[f]}")
                  ss -nltp | grep -q ":$PORT" && info " $(text_eval 122) " || error " $(text 34) " ;;
          * ) warning " $(text 51) [1-2] "; sleep 1; change_port ;;
        esac ;;
  esac  
}

# 选用 iptables+dnsmasq+ipset 方案执行
iptables_solution() {
  ${PACKAGE_INSTALL[int]} ipset dnsmasq resolvconf mtr

  # 创建 dnsmasq 规则文件
  cat >/etc/dnsmasq.d/warp.conf << EOF
#!/usr/bin/env bash
server=1.1.1.1
server=8.8.8.8
# ----- WARP ----- #
# > Youtube Premium
server=/googlevideo.com/1.1.1.1
server=/youtube.com/1.1.1.1
server=/youtubei.googleapis.com/1.1.1.1
server=/fonts.googleapis.com/1.1.1.1
server=/yt3.ggpht.com/1.1.1.1
server=/gstatic.com/1.1.1.1

ipset=/www.cloudflare.com/warp
ipset=/ip.gs/warp
ipset=/ifconfig.co/warp
ipset=/googlevideo.com/warp
ipset=/youtube.com/warp
ipset=/youtubei.googleapis.com/warp
ipset=/fonts.googleapis.com/warp
ipset=/yt3.ggpht.com/warp

# > Netflix
ipset=/fast.com/warp
ipset=/netflix.com/warp
ipset=/netflix.net/warp
ipset=/nflxext.com/warp
ipset=/nflximg.com/warp
ipset=/nflximg.net/warp
ipset=/nflxso.net/warp
ipset=/nflxvideo.net/warp

# > TVBAnywhere+
ipset=/uapisfm.tvbanywhere.com.sg/warp

# > Disney+
ipset=/bamgrid.com/warp
ipset=/disney-plus.net/warp
ipset=/disneyplus.com/warp
ipset=/dssott.com/warp
ipset=/disneynow.com/warp
ipset=/disneystreaming.com/warp
ipset=/cdn.registerdisney.go.com/warp

# > TikTok
ipset=/byteoversea.com/warp
ipset=/ibytedtos.com/warp
ipset=/ipstatp.com/warp
ipset=/muscdn.com/warp
ipset=/musical.ly/warp
ipset=/tiktok.com/warp
ipset=/tik-tokapi.com/warp
ipset=/tiktokcdn.com/warp
ipset=/tiktokv.com/warp
EOF
                
  # 创建 PostUp 和 PreDown
  cat >/etc/wireguard/up << EOF
#!/usr/bin/env bash

ipset create warp hash:ip
iptables -t mangle -N fwmark
iptables -t mangle -A PREROUTING -j fwmark
iptables -t mangle -A OUTPUT -j fwmark
iptables -t mangle -A fwmark -m set --match-set warp dst -j MARK --set-mark 2
ip rule add fwmark 2 table warp
ip route add default dev wgcf table warp
iptables -t nat -A POSTROUTING -m mark --mark 0x2 -j MASQUERADE
iptables -t mangle -A POSTROUTING -o wgcf -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu   
EOF

  cat >/etc/wireguard/down << EOF
#!/usr/bin/env bash

iptables -t mangle -D PREROUTING -j fwmark
iptables -t mangle -D OUTPUT -j fwmark
iptables -t mangle -D fwmark -m set --match-set warp dst -j MARK --set-mark 2
ip rule del fwmark 2 table warp
iptables -t mangle -D POSTROUTING -o wgcf -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
iptables -t nat -D POSTROUTING -m mark --mark 0x2 -j MASQUERADE
iptables -t mangle -F fwmark
iptables -t mangle -X fwmark
sleep 2
ipset destroy warp
EOF

  chmod +x /etc/wireguard/up /etc/wireguard/down

  # 修改 wgcf.conf 和 warp.conf 文件
  sed -i "s/^Post.*/#&/g;\$a PersistentKeepalive = 5; 7 i Table = off\nPostUp = /etc/wireguard/up\nPredown = /etc/wireguard/down" /etc/wireguard/wgcf.conf
  [ "$m" = 0 ] && sed -i "2i server=2606:4700:4700::1111\nserver=2001:4860:4860::8888\nserver=2001:4860:4860::8844" /etc/dnsmasq.d/warp.conf
  ! grep -q 'warp' /etc/iproute2/rt_tables && echo '250   warp' >>/etc/iproute2/rt_tables
  systemctl disable systemd-resolved --now >/dev/null 2>&1 && sleep 2
  systemctl enable dnsmasq --now >/dev/null 2>&1 && sleep 2
}

# WGCF 或 WireProxy 安装
install() {
  # WireProxy 禁止重复安装，自定义 Port
  if [ "$OCTEEP" = 1 ]; then
    ss -nltp | grep -q wireproxy && error " $(text 166) " || input_port

  # iptables 禁止重复安装，不适用于 IPv6 only VPS
  elif [ "$ANEMONE" = 1 ]; then
    [ -e /etc/dnsmasq.d/warp.conf ] && error " $(text 167) "
    [ "$m" = 0 ] && error " $(text 147) " || CONF=${CONF1[n]}
  fi

  # CONF 参数如果不是3位或4位， 即检测不出正确的配置参数， 脚本退出
  [[ "$OCTEEP" != 1 && "${#CONF}" != [34] ]] && error " $(text 172) "

  # 先删除之前安装，可能导致失败的文件
  rm -rf /usr/bin/wgcf /usr/bin/wireguard-go /etc/wireguard/wgcf-account.toml

  # 询问是否有 WARP+ 或 Teams 账户
  [ -z "$CHOOSE_TYPE" ] && hint "\n $(text 132) \n" && reading " $(text 50) " CHOOSE_TYPE
  case "$CHOOSE_TYPE" in
    2 ) INPUT_LICENSE=1 && input_license ;;
    3 ) input_url ;;
  esac

  # 选择优先使用 IPv4 /IPv6 网络
  [ "$OCTEEP" != 1 ] && hint "\n $(text 105) \n" && reading " $(text 50) " PRIORITY

  # 脚本开始时间
  start=$(date +%s)

  # 注册 WARP 账户 (将生成 wgcf-account.toml 文件保存账户信息)
  # 判断 wgcf 的最新版本,如因 github 接口问题未能获取，默认 v2.2.15
  {     
    latest=$(wget --no-check-certificate -qO- -T1 -t1 $CDN "https://api.github.com/repos/ViRb3/wgcf/releases/latest" | grep "tag_name" | head -n 1 | cut -d : -f2 | sed 's/[ \"v,]//g')
    latest=${latest:-'2.2.15'}

    # 安装 wgcf，尽量下载官方的最新版本，如官方 wgcf 下载不成功，将使用 githubusercontents 的 CDN，以更好的支持双栈。并添加执行权限
    wget --no-check-certificate -T1 -t1 $CDN -O /usr/bin/wgcf https://github.com/ViRb3/wgcf/releases/download/v"$latest"/wgcf_"$latest"_linux_$ARCHITECTURE ||
    wget --no-check-certificate $CDN -O /usr/bin/wgcf https://raw.githubusercontent.com/fscarmen/warp/main/wgcf/wgcf_"$latest"_linux_$ARCHITECTURE
    chmod +x /usr/bin/wgcf

    # 如安装 WireProxy ，尽量下载官方的最新版本，如官方 WireProxy 下载不成功，将使用 githubusercontents 的 CDN，以更好的支持双栈。并添加执行权限
    if [ "$OCTEEP" = 1 ]; then
      wireproxy_latest=$(wget --no-check-certificate -qO- -T1 -t1 $CDN "https://api.github.com/repos/octeep/wireproxy/releases/latest" | grep "tag_name" | head -n 1 | cut -d : -f2 | sed 's/[ \"v,]//g')
      wireproxy_latest=${wireproxy_latest:-'1.0.3'}
      wget --no-check-certificate -T1 -t1 $CDN -N https://github.com/octeep/wireproxy/releases/download/v"$wireproxy_latest"/wireproxy_linux_$ARCHITECTURE.tar.gz ||
      wget --no-check-certificate $CDN -N https://raw.githubusercontent.com/fscarmen/warp/main/wireproxy/wireproxy_linux_$ARCHITECTURE.tar.gz
      [ $(type -p tar) ] || ${PACKAGE_INSTALL[int]} tar 2>/dev/null || ( ${PACKAGE_UPDATE[int]}; ${PACKAGE_INSTALL[int]} tar 2>/dev/null )
      tar xzf wireproxy_linux_$ARCHITECTURE.tar.gz -C /usr/bin/; rm -f wireproxy_linux*
    fi

    # 注册 WARP 账户 ( wgcf-account.toml 使用默认值加加快速度)。如有 WARP+ 账户，修改 license 并升级，并把设备名等信息保存到 /etc/wireguard/info.log
    mkdir -p /etc/wireguard/ >/dev/null 2>&1
    until [ -e /etc/wireguard/wgcf-account.toml ]; do
      wgcf register --accept-tos --config /etc/wireguard/wgcf-account.toml >/dev/null 2>&1 && break
    done
    if [ -n "$LICENSE" ]; then
      cp -f /etc/wireguard/wgcf-account.toml /etc/wireguard/account-temp.toml || exit 1
      sed -i "s#license_key.*#license_key = \"$LICENSE\"#g" /etc/wireguard/account-temp.toml
      wgcf update --name "$NAME" --config /etc/wireguard/account-temp.toml > /etc/wireguard/info.log 2>&1
      while grep -qisE "429 Too Many Requests|time.*out" /etc/wireguard/info.log; do
        /usr/bin/wgcf update --name "$NAME" --config /etc/wireguard/account-temp.toml > /etc/wireguard/info.log 2>&1
      done
      if grep -qs "400 Bad Request" /etc/wireguard/info.log; then
        rm -f /etc/wireguard/account-temp.toml /etc/wireguard/info.log && warning " $(text_eval 36) "
      elif grep -qs "Account type  : free" /etc/wireguard/info.log; then
        rm -f /etc/wireguard/account-temp.toml /etc/wireguard/info.log && warning " $(text_eval 42) "
      elif grep -qs "Account type  : limited" /etc/wireguard/info.log; then
        mv -f /etc/wireguard/account-temp.toml /etc/wireguard/wgcf-account.toml
      fi
    fi

    # 生成 Wire-Guard 配置文件 (wgcf.conf)
    if [ -e /etc/wireguard/wgcf-account.toml ]; then
      until [ -e /etc/wireguard/wgcf.conf ]; do
        wgcf generate --config /etc/wireguard/wgcf-account.toml --profile /etc/wireguard/wgcf.conf >/dev/null 2>&1
      done
      info "\n $(text 33) \n"
    fi

    # 反复测试最佳 MTU。 Wireguard Header:IPv4=60 bytes,IPv6=80 bytes，1280 ≤ MTU ≤ 1420。 ping = 8(ICMP回显示请求和回显应答报文格式长度) + 20(IP首部) 。
    # 详细说明:<[WireGuard] Header / MTU sizes for Wireguard>:https://lists.zx2c4.com/pipermail/wireguard/2017-December/002201.html
    MTU=$((1500-28))
    [ "$IPV4$IPV6" = 01 ] && $PING6 -c1 -W1 -s $MTU -Mdo 2606:4700:d0::a29f:c001 >/dev/null 2>&1 || ping -c1 -W1 -s $MTU -Mdo 162.159.193.10 >/dev/null 2>&1
    until [[ $? = 0 || $MTU -le $((1280+80-28)) ]]; do
      MTU=$((MTU-10))
      [ "$IPV4$IPV6" = 01 ] && $PING6 -c1 -W1 -s $MTU -Mdo 2606:4700:d0::a29f:c001 >/dev/null 2>&1 || ping -c1 -W1 -s $MTU -Mdo 162.159.193.10 >/dev/null 2>&1
    done

    if [ "$MTU" -eq $((1500-28)) ]; then
      MTU=$MTU
    elif [ "$MTU" -le $((1280+80-28)) ]; then
      MTU=$((1280+80-28))
    else
      for ((i=0; i<9; i++)); do
        (( MTU++ ))
        ( [ "$IPV4$IPV6" = 01 ] && $PING6 -c1 -W1 -s $MTU -Mdo 2606:4700:d0::a29f:c001 >/dev/null 2>&1 || ping -c1 -W1 -s $MTU -Mdo 162.159.193.10 >/dev/null 2>&1 ) || break
      done
      (( MTU-- ))
    fi

    MTU=$((MTU+28-80))

    [ -e /etc/wireguard/wgcf.conf ] && sed -i "s/MTU.*/MTU = $MTU/g" /etc/wireguard/wgcf.conf && info "\n $(text 81) \n"
  }&

  # 对于 IPv4 only VPS 开启 IPv6 支持
  # 感谢 P3terx 大神项目这块的技术指导。项目:https://github.com/P3TERX/warp.sh/blob/main/warp.sh
  {
    [ "$IPV4$IPV6" = 10 ] && [[ $(sysctl -a 2>/dev/null | grep 'disable_ipv6.*=.*1') || $(grep -s "disable_ipv6.*=.*1" /etc/sysctl.{conf,d/*} ) ]] &&
    (sed -i '/disable_ipv6/d' /etc/sysctl.{conf,d/*}
    echo 'net.ipv6.conf.all.disable_ipv6 = 0' >/etc/sysctl.d/ipv6.conf
    sysctl -w net.ipv6.conf.all.disable_ipv6=0)
  }&

  # 优先使用 IPv4 /IPv6 网络
  { stack_priority; }&

  # 根据系统选择需要安装的依赖
  info "\n $(text 32) \n"

  Debian() {
    # 添加 backports 源,之后才能安装 wireguard-tools 
    if [[ $(echo $SYS | sed "s/[^0-9.]//g" | cut -d. -f1) = 9 ]]; then
      echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable-wireguard.list
      echo -e "Package: *\nPin: release a=unstable\nPin-Priority: 150\n" > /etc/apt/preferences.d/limit-unstable
    else
      echo "deb http://deb.debian.org/debian $(cat /etc/os-release | grep -i VERSION_CODENAME | sed s/.*=//g)-backports main" > /etc/apt/sources.list.d/backports.list
    fi  
    # 更新源
    ${PACKAGE_UPDATE[int]}

    # 安装一些必要的网络工具包和wireguard-tools (Wire-Guard 配置工具:wg、wg-quick)
    ${PACKAGE_INSTALL[int]} --no-install-recommends net-tools openresolv dnsutils iptables
    [ "$OCTEEP" != 1 ] && ${PACKAGE_INSTALL[int]} --no-install-recommends wireguard-tools

    # 如 Linux 版本低于5.6并且是 kvm，则安装 wireguard 内核模块
    [ "$WG" = 1 ] && ${PACKAGE_INSTALL[int]} --no-install-recommends linux-headers-"$(uname -r)" && ${PACKAGE_INSTALL[int]} --no-install-recommends wireguard-dkms
  }

  Ubuntu() {
    # 更新源
    ${PACKAGE_UPDATE[int]}

    # 安装一些必要的网络工具包和 wireguard-tools (Wire-Guard 配置工具:wg、wg-quick)
    ${PACKAGE_INSTALL[int]} --no-install-recommends net-tools openresolv dnsutils iptables
    [ "$OCTEEP" != 1 ] && ${PACKAGE_INSTALL[int]} --no-install-recommends wireguard-tools
  }

  CentOS() {
    # 安装一些必要的网络工具包和wireguard-tools (Wire-Guard 配置工具:wg、wg-quick)
    [ "$COMPANY" = amazon ] && ${PACKAGE_UPDATE[int]} && amazon-linux-extras install -y epel            
    ${PACKAGE_INSTALL[int]} epel-release
    ${PACKAGE_INSTALL[int]} net-tools iptables
    [ "$OCTEEP" != 1 ] && ${PACKAGE_INSTALL[int]} wireguard-tools

    # 如 Linux 版本低于5.6并且是 kvm，则安装 wireguard 内核模块
    VERSION_ID=$(expr "$SYS" : '.*\s\([0-9]\{1,\}\)\.*')
    [ "$ARCHITECTURE" != s390x ] && [ "$WG" = 1 ] && curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-"$VERSION_ID"/jdoss-wireguard-epel-"$VERSION_ID".repo &&

    ${PACKAGE_INSTALL[int]} wireguard-dkms

    # 升级所有包同时也升级软件和系统内核
    ${PACKAGE_UPDATE[int]}

    # s390x wireguard-tools 安装
    [ "$ARCHITECTURE" = s390x ] && [ ! $(type -p wg) ] && rpm -i https://mirrors.cloud.tencent.com/epel/8/Everything/s390x/Packages/w/wireguard-tools-1.0.20210914-1.el8.s390x.rpm

    # CentOS Stream 9 需要安装 resolvconf
    [[ "$SYSTEM" = CentOS && "$(expr "$SYS" : '.*\s\([0-9]\{1,\}\)\.*')" = 9 ]] && [ ! $(type -p resolvconf) ] && 
    wget $CDN -P /usr/sbin https://github.com/fscarmen/warp/releases/download/resolvconf/resolvconf && chmod +x /usr/sbin/resolvconf
  }

  Alpine() {
    # 安装一些必要的网络工具包和wireguard-tools (Wire-Guard 配置工具:wg、wg-quick)
    ${PACKAGE_INSTALL[int]} net-tools iproute2 openresolv openrc iptables ip6tables
    [ "$OCTEEP" != 1 ] && ${PACKAGE_INSTALL[int]} wireguard-tools
  }

  Arch() {
    # 安装一些必要的网络工具包和wireguard-tools (Wire-Guard 配置工具:wg、wg-quick)
    ${PACKAGE_INSTALL[int]} openresolv
    [ "$OCTEEP" != 1 ] && ${PACKAGE_INSTALL[int]} wireguard-tools
  }

  $SYSTEM

  wait

  # WGCF 配置修改，其中用到的 162.159.193.10 和 2606:4700:d0::a29f:c001 均是 engage.cloudflareclient.com 的 IP
  MODIFY014='sed -i "s/1.1.1.1/2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844,1.1.1.1,8.8.8.8,8.8.4.4/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;s/engage.cloudflareclient.com/[2606:4700:d0::a29f:c001]/g;s/^.*\:\:\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY016='sed -i "s/1.1.1.1/2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844,1.1.1.1,8.8.8.8,8.8.4.4/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;s/engage.cloudflareclient.com/[2606:4700:d0::a29f:c001]/g;s/^.*0\.\0\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY01D='sed -i "s/1.1.1.1/2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844,1.1.1.1,8.8.8.8,8.8.4.4/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;s/engage.cloudflareclient.com/[2606:4700:d0::a29f:c001]/g" /etc/wireguard/wgcf.conf'
  MODIFY104='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/162.159.193.10/g;s/^.*\:\:\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY106='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/162.159.193.10/g;s/^.*0\.\0\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY10D='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/162.159.193.10/g" /etc/wireguard/wgcf.conf'
  MODIFY114='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/162.159.193.10/g;s/^.*\:\:\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY116='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/162.159.193.10/g;s/^.*0\.\0\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY11D='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/162.159.193.10/g" /etc/wireguard/wgcf.conf'
  MODIFY11N4='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/[2606:4700:d0::a29f:c001]/g;s/^.*\:\:\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY11N6='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/[2606:4700:d0::a29f:c001]/g;s/^.*0\.\0\/0/#&/g" /etc/wireguard/wgcf.conf'
  MODIFY11ND='sed -i "s/1.1.1.1/1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844/g;7 s/^/PostDown = ip -6 rule delete from '$LAN6' lookup main\n/;7 s/^/PostUp = ip -6 rule add from '$LAN6' lookup main\n/;7 s/^/PostDown = ip -4 rule delete from '$LAN4' lookup main\n/;7 s/^/PostUp = ip -4 rule add from '$LAN4' lookup main\n/;s/engage.cloudflareclient.com/[2606:4700:d0::a29f:c001]/g" /etc/wireguard/wgcf.conf'

  sh -c "$(eval echo "\$MODIFY$CONF")"

  if [ "$OCTEEP" = 1 ]; then
    # 默认 Endpoint 和 DNS 默认 IPv4 和 双栈的，如是 IPv6 修改默认值
    ENDPOINT='162.159.193.10'
    DNS='1.1.1.1,8.8.8.8,8.8.4.4,2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844'
    [ "$m" = 0 ] && ENDPOINT='[2606:4700:d0::a29f:c001]' && DNS='2606:4700:4700::1111,2001:4860:4860::8888,2001:4860:4860::8844,1.1.1.1,8.8.8.8,8.8.4.4'
    MTU=$(grep MTU /etc/wireguard/wgcf.conf | sed "s/MTU = //g")
    PRIVATEKEY=${PRIVATEKEY:-"$(grep PrivateKey /etc/wireguard/wgcf.conf | sed "s/PrivateKey = //g")"}

    # 创建 WirePorxy 配置文件
    cat > /etc/wireguard/proxy.conf << EOF
# The [Interface] and [Peer] configurations follow the same semantics and meaning
# of a wg-quick configuration. To understand what these fields mean, please refer to:
# https://wiki.archlinux.org/title/WireGuard#Persistent_configuration
# https://www.wireguard.com/#simple-network-interface
[Interface]
Address = 172.16.0.2/32 # The subnet should be /32 and /128 for IPv4 and v6 respectively
MTU = $MTU
PrivateKey = $PRIVATEKEY
DNS = $DNS

[Peer]
PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
# PresharedKey = UItQuvLsyh50ucXHfjF0bbR4IIpVBd74lwKc8uIPXXs= (optional)
Endpoint = $ENDPOINT:1701
# PersistentKeepalive = 25 (optional)

# TCPClientTunnel is a tunnel listening on your machine,
# and it forwards any TCP traffic received to the specified target via wireguard.
# Flow:
# <an app on your LAN> --> localhost:25565 --(wireguard)--> play.cubecraft.net:25565
#[TCPClientTunnel]
#BindAddress = 127.0.0.1:25565
#Target = play.cubecraft.net:25565

# TCPServerTunnel is a tunnel listening on wireguard,
# and it forwards any TCP traffic received to the specified target via local network.
# Flow:
# <an app on your wireguard network> --(wireguard)--> 172.16.31.2:3422 --> localhost:25545
#[TCPServerTunnel]
#ListenPort = 3422
#Target = localhost:25545

# Socks5 creates a socks5 proxy on your LAN, and all traffic would be routed via wireguard.
[Socks5]
BindAddress = 127.0.0.1:$PORT

# Socks5 authentication parameters, specifying username and password enables
# proxy authentication.
#Username = ...
# Avoid using spaces in the password field
#Password = ...
EOF

    # 创建 WireProxy systemd 进程守护
    if [ "$SYSTEM" != Alpine ]; then
      cat > /lib/systemd/system/wireproxy.service << EOF
[Unit]
Description=WireProxy for WARP
After=network.target
Documentation=https://github.com/fscarmen/warp
Documentation=https://github.com/octeep/wireproxy

[Service]
ExecStart=/usr/bin/wireproxy -c /etc/wireguard/proxy.conf
RemainAfterExit=yes
Restart=always

[Install]
WantedBy=multi-user.target
EOF
    fi

    # 运行 wireproxy
    systemctl enable --now wireproxy; sleep 1

    # 保存好配置文件, 如有 Teams，改为 Teams 账户信息    
    mv -f menu.sh /etc/wireguard >/dev/null 2>&1
    [[ "$CONFIRM" = [Yy] ]] && teams_change && echo "$TEAMS" > /etc/wireguard/info-temp.log 2>&1

    # 创建再次执行的软链接快捷方式，再次运行可以用 warp 指令,设置默认语言
    chmod +x /etc/wireguard/menu.sh >/dev/null 2>&1
    ln -sf /etc/wireguard/menu.sh /usr/bin/warp && info " $(text 38) "
    echo "$L" >/etc/wireguard/language

    # 结果提示，脚本运行时间，次数统计
    proxy_info
    end=$(date +%s)
    info " $(text_eval 149)\n $(text 27): $PROXYSOCKS52\n WARP$AC2 IPv4: $PROXYIP2 $PROXYCOUNTRY2 $PROXYASNORG2 "
    [ -n "$QUOTA" ] && info " $(text 63): $QUOTA "
    echo -e "\n==============================================================\n"
    hint " $(text 43) \n" && help

  else
    [ "$ANEMONE" = 1 ] && iptables_solution

    # 如有 Teams，改为 Teams 账户信息
    grep -qiw "y" <<< "$CONFIRM" && teams_change && echo "$TEAMS" > /etc/wireguard/info-temp.log 2>&1

    # 设置开机启动
    ${SYSTEMCTL_ENABLE[int]} >/dev/null 2>&1
    [ $(type -p dnsmasq) ] && systemctl restart dnsmasq >/dev/null 2>&1

    # Linux 内核低于5.6的，安装 Wireguard-GO。部分较低内核版本的KVM，即使安装了wireguard-dkms, 仍不能正常工作，兜底使用 wireguard-go
    if [ "$WG" = 1 ] || [[ $(systemctl is-active wg-quick@wgcf) != active ]] || [[ $(systemctl is-enabled wg-quick@wgcf) != enabled ]]; then
      systemctl disable --now wg-quick@wgcf >/dev/null 2>&1
      wget --no-check-certificate $CDN -N https://raw.githubusercontent.com/fscarmen/warp/main/wireguard-go/wireguard-go_linux_"$ARCHITECTURE".tar.gz
      [ $(type -p tar) ] || ${PACKAGE_INSTALL[int]} tar 2>/dev/null || ( ${PACKAGE_UPDATE[int]}; ${PACKAGE_INSTALL[int]} tar 2>/dev/null )
      tar xzf wireguard-go_linux_$ARCHITECTURE.tar.gz -C /usr/bin/ && rm -f wireguard-go_linux_* && chmod +x /usr/bin/wireguard-go
      ${SYSTEMCTL_ENABLE[int]} >/dev/null 2>&1
    fi
  
    # 创建再次执行的软链接快捷方式，再次运行可以用 warp 指令,设置默认语言
    mv -f menu.sh /etc/wireguard >/dev/null 2>&1
    chmod +x /etc/wireguard/menu.sh >/dev/null 2>&1
    ln -sf /etc/wireguard/menu.sh /usr/bin/warp && info " $(text 38) "
    echo "$L" >/etc/wireguard/language

    # 自动刷直至成功（ warp bug，有时候获取不了ip地址），重置之前的相关变量值，记录新的 IPv4 和 IPv6 地址和归属地，IPv4 / IPv6 优先级别
    info " $(text 39) "
    unset IP4 IP6 WAN4 WAN6 COUNTRY4 COUNTRY6 ASNORG4 ASNORG6 TRACE4 TRACE6 PLUS4 PLUS6 WARPSTATUS4 WARPSTATUS6
    [ "$COMPANY" = amazon ] && warning " $(text_eval 40) " && reboot || net
    result_priority
  
    # /etc/wireguard/info-temp.log 存在，说明升级 Teams 成功，移动文件到 /etc/wireguard/info.log
    grep -qiw "y" <<< "$CONFIRM" && [ -e /etc/wireguard/info-temp.log ] && mv -f /etc/wireguard/info-temp.log /etc/wireguard/info.log

    # 部分 LXC 内核已经包含 WireGuard 模块则会优先使用，此场景下删除 WireGuard-go
    [ -e /usr/bin/wireguard-go ] && ! pgrep -laf "wireguard-go" >/dev/null 2>&1 && rm -f /usr/bin/wireguard-go

    # 结果提示，脚本运行时间，次数统计
    end=$(date +%s)
    echo -e "\n==============================================================\n"
    info " IPv4: $WAN4 $WARPSTATUS4 $COUNTRY4  $ASNORG4 "
    info " IPv6: $WAN6 $WARPSTATUS6 $COUNTRY6  $ASNORG6 "
    info " $(text_eval 41) " && [ -n "$QUOTA" ] && info " $(text_eval 133) "
    info " $PRIORITY_NOW "
    echo -e "\n==============================================================\n"
    hint " $(text 43)\n " && help
    [[ "$TRACE4$TRACE6" = offoff ]] && warning " $(text 44) "
  fi
  }

proxy() {
  settings() {
    # 设置为代理模式，如有 WARP+ 账户，修改 license 并升级
    info " $(text 84) "
    warp-cli --accept-tos register >/dev/null 2>&1
    [ -n "$LICENSE" ] && ( hint " $(text 35) " &&
    warp-cli --accept-tos set-license "$LICENSE" >/dev/null 2>&1 && sleep 1 &&
    ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null) &&
    [[ "$ACCOUNT" =~ Limited ]] && TYPE='+' && echo "$LICENSE" > /etc/wireguard/license && info " $(text_eval 62) " ||
    warning " $(text_eval 36) " )
    if [ "$LUBAN" = 1 ]; then
      i=1; j=5; INTERFACE='--interface CloudflareWARP'
      hint " $(text_eval 11)\n $(text_eval 12) "
      warp-cli --accept-tos add-excluded-route 0.0.0.0/0 >/dev/null 2>&1
      warp-cli --accept-tos add-excluded-route ::0/0 >/dev/null 2>&1
      warp-cli --accept-tos set-mode warp >/dev/null 2>&1
      warp-cli --accept-tos connect >/dev/null 2>&1
      warp-cli --accept-tos enable-always-on >/dev/null 2>&1
      sleep 5
      rule_add >/dev/null 2>&1
      ip4_info
      until [ -n "$IP4" ]; do
        (( i++ )) || true
        hint " $(text_eval 12) "
        warp-cli --accept-tos disconnect >/dev/null 2>&1
        warp-cli --accept-tos disable-always-on >/dev/null 2>&1
        rule_del >/dev/null 2>&1
        sleep 2
        warp-cli --accept-tos connect >/dev/null 2>&1
        warp-cli --accept-tos enable-always-on >/dev/null 2>&1
        sleep 5
        rule_add >/dev/null 2>&1
        ip4_info
        if [ "$i" = "$j" ]; then
          warp-cli --accept-tos disconnect >/dev/null 2>&1
          warp-cli --accept-tos disable-always-on >/dev/null 2>&1
          rule_del >/dev/null 2>&1
          error " $(text_eval 13) "
        fi
      done
      info " $(text_eval 14) "
    else
      warp-cli --accept-tos set-mode proxy >/dev/null 2>&1
      warp-cli --accept-tos set-proxy-port "$PORT" >/dev/null 2>&1
      warp-cli --accept-tos connect >/dev/null 2>&1
      warp-cli --accept-tos enable-always-on >/dev/null 2>&1
      sleep 2 && [[ ! $(ss -nltp) =~ warp-svc ]] && error " $(text 87) " || info " $(text_eval 86) "
    fi
  }

  # 禁止安装的情况。重复安装，非 AMD64 CPU 架构，IPv4 是 WARP
  [ "$CLIENT" -ge 2 ] && error " $(text 85) "
  [ "$ARCHITECTURE" != amd64 ] && error " $(text_eval 101) "
  [ "$TRACE4" != off ] && error " $(text 95) "

  # 安装 WARP Linux Client
  input_license
  [ "$LUBAN" != 1 ] && input_port
  start=$(date +%s)
  VERSION_ID=$(grep -i VERSION_ID /etc/os-release | cut -d \" -f2)
  mkdir -p /etc/wireguard/ >/dev/null 2>&1
  if [ "$CLIENT" = 0 ]; then info " $(text 83) "
    if [ "$SYSTEM" = CentOS ]; then
      { wget https://github.com/fscarmen/warp/raw/main/Client/Client_CentOS_8.rpm; } &
      [ ! $(type -p desktop-file-install) ] && ${PACKAGE_INSTALL[int]} desktop-file-utils
      case "$(expr "$SYS" : '.*\s\([0-9]\{1,\}\)\.*')" in
        7 ) #  CentOS 7，需要用 Cloudflare CentOS 8 的库以安装 Client，并在线编译升级 C 运行库 Glibc 2.28
            ${PACKAGE_INSTALL[int]} nftables
            rpm -ivh Client_CentOS_8.rpm
            if [[ ! $(strings /lib64/libc.so.6) =~ GLIBC_2.28 ]]; then
              GLIBC=1
              wget -O /usr/bin/make https://github.com/fscarmen/warp/releases/download/Glibc/make
              wget https://github.com/fscarmen/warp/releases/download/Glibc/glibc-2.28.tar.gz
              tar -xzvf glibc-2.28.tar.gz
              [ $(type -p tar) ] || ${PACKAGE_INSTALL[int]} tar 2>/dev/null || ( ${PACKAGE_UPDATE[int]}; ${PACKAGE_INSTALL[int]} tar 2>/dev/null )
              ${PACKAGE_INSTALL[int]} gcc bison make centos-release-scl
              ${PACKAGE_INSTALL[int]} devtoolset-8-gcc devtoolset-8-gcc-c++ devtoolset-8-binutils
              source /opt/rh/devtoolset-8/enable
              wait
              cd ./glibc-2.28/build || error " $(text 58) "
              ../configure --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin
              make install
              cd ../..
              rm -rf glibc-2.28*
              ! systemctl is-active warp-svc >/dev/null 2>&1 && systemctl enable --now warp-svc
            fi ;;

        8|9 ) rpm -ivh Client_CentOS_8.rpm ;;
      esac
      rm -f Client_CentOS_8.rpm
    else
      { wget --no-check-certificate $CDN https://github.com/fscarmen/warp/raw/main/Client/Client_${SYSTEM}_${VERSION_ID}.deb; }&
      ${PACKAGE_UPDATE[int]}
      [[ "$SYSTEM" = Debian && ! $(apt list 2>/dev/null | grep apt-transport-https) =~ installed ]] && ${PACKAGE_INSTALL[int]} apt-transport-https
      wait
      dpkg -i Client_${SYSTEM}_${VERSION_ID}.deb >/dev/null 2>&1
      ${PACKAGE_INSTALL[int]} -f
      ${PACKAGE_INSTALL[int]} gnupg2 desktop-file-utils
      dpkg -i Client_${SYSTEM}_${VERSION_ID}.deb
      rm -f Client_${SYSTEM}_${VERSION_ID}.deb
      sleep 1
    fi
    [ "$(systemctl is-active warp-svc)" != active ] && ( systemctl start warp-svc; sleep 2 )
    settings

  elif [[ "$CLIENT" = 2 && "$(warp-cli --accept-tos status 2>/dev/null)" =~ 'Registration missing' ]]; then
    settings

  else
    warning " $(text 85) "

  fi

  # 此处为处理 CentOS 7 安装 Glibc 2.28 之后 Running transaction test 不动的问题
  if [ "$GLIBC" = 1 ]; then
    rm -rf /var/lib/rpm/__db*
    yum clean all
    rpm --rebuilddb
  fi

  # 创建再次执行的软链接快捷方式，再次运行可以用 warp 指令,设置默认语言
  mv -f menu.sh /etc/wireguard >/dev/null 2>&1
  chmod +x /etc/wireguard/menu.sh >/dev/null 2>&1
  ln -sf /etc/wireguard/menu.sh /usr/bin/warp && info " $(text 38) "
  echo "$L" >/etc/wireguard/language

  # 结果提示，脚本运行时间，次数统计
  ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null)
  [[ "$ACCOUNT" =~ Limited ]] && CHECK_TYPE=1 && AC='+' && check_quota

  if [ "$LUBAN" = 1 ]; then
    [ "$L" = C ] && COUNTRY4=$(translate "$COUNTRY4")
    end=$(date +%s)
    echo -e "\n==============================================================\n"
    info " $(text_eval 94)\n $(text_eval 169) "

  else
    proxy_info
    end=$(date +%s)
    echo -e "\n==============================================================\n"
    info " $(text_eval 94)\n $(text 27): $PROXYSOCKS5\n WARP$AC IPv4: $PROXYIP $PROXYCOUNTRY $PROXYASNORG "
  fi

  [[ "$ACCOUNT" =~ Limited ]] && info " $(text 63): $QUOTA "
  echo -e "\n==============================================================\n"
  hint " $(text 43)\n " && help
}

# iptables+dnsmasq+ipset 方案，IPv6 only 不适用
stream_solution() {
  [ "$m" = 0 ] && error " $(text 147) "

  echo -e "\n==============================================================\n"
  info " $(text 139) "
  echo -e "\n==============================================================\n"
  hint " 1. $(text 48) "
  [ "$OPTION" != e ] && hint " 0. $(text 49) \n" || hint " 0. $(text 76) \n"
  reading " $(text 50) " IPTABLES
  case "$IPTABLES" in
    1 ) CONF=${CONF1[n]}; ANEMONE=1; install ;;
    0 ) [ "$OPTION" != e ] && menu || exit ;;
    * ) warning " $(text 51) [0-1]"; sleep 1; stream_solution ;;
  esac
}

# wireproxy 方案
wireproxy_solution() {
  ss -nltp | grep -q wireproxy && error " $(text 166) "

  echo -e "\n==============================================================\n"
  info " $(text 165) "
  echo -e "\n==============================================================\n"
  hint " 1. $(text 48) "
  [ "$OPTION" != w ] && hint " 0. $(text 49) \n" || hint " 0. $(text 76) \n"
  reading " $(text 50) " WIREPROXY_CHOOSE
  case "$WIREPROXY_CHOOSE" in
    1 ) OCTEEP=1; install ;;
    0 ) [ "$OPTION" != w ] && menu || exit ;;
    * ) warning " $(text 51) [0-1]"; sleep 1; wireproxy_solution ;;
  esac
}

# 查 WARP+ 余额流量接口
check_quota() {
  if [ "$CHECK_TYPE" = 1 ]; then
    QUOTA=$(grep -oP 'Quota: \K\d+' <<< $ACCOUNT)
  elif [ -e /etc/wireguard/wgcf-account.toml ]; then
    ACCESS_TOKEN=$(grep 'access_token' /etc/wireguard/wgcf-account.toml | cut -d \' -f2)
    DEVICE_ID=$(grep 'device_id' /etc/wireguard/wgcf-account.toml | cut -d \' -f2)
    API=$(curl -s "https://api.cloudflareclient.com/v0a884/reg/$DEVICE_ID" -H "User-Agent: okhttp/3.12.1" -H "Authorization: Bearer $ACCESS_TOKEN")
    QUOTA=$(sed 's/.*quota":\([^,]\+\).*/\1/g' <<< $API)
  fi

  # 部分系统没有依赖 bc，所以两个小数不能用 $(echo "scale=2; $QUOTA/1000000000000000" | bc)，改为从右往左数字符数的方法
  if [[ "$QUOTA" != 0 && "$QUOTA" =~ ^[0-9]+$ && "$QUOTA" -ge 1000000 ]]; then  
    CONVERSION=("1000000000000000000" "1000000000000000" "1000000000000" "1000000000" "1000000")
    UNIT=("EB" "PB" "TB" "GB" "MB")
    for ((o=0; o<${#CONVERSION[*]}; o++)); do
      [[ "$QUOTA" -ge "${CONVERSION[o]}" ]] && break
    done

    QUOTA_INTEGER=$(( $QUOTA / ${CONVERSION[o]} ))
    QUOTA_DECIMALS=${QUOTA:0-$(( ${#CONVERSION[o]} - 1 )):2}
    QUOTA="$QUOTA_INTEGER.$QUOTA_DECIMALS ${UNIT[o]}"
  fi
}

# 更换为免费账户
change_to_free() {
  if [ "$UPDATE_ACCOUNT" = client ]; then
    [[ $(warp-cli --accept-tos settings) =~ WarpProxy ]] && CLIENT_PROXY=1
    warp-cli --accept-tos delete >/dev/null 2>&1
    [ "$CLIENT_PROXY" != 1 ] && rule_del >/dev/null 2>&1
    warp-cli --accept-tos register >/dev/null 2>&1
    unset AC && TYPE=' free' && rm -f /etc/wireguard/license
    sleep 2
    if [ "$CLIENT_PROXY" != 1 ]; then
      rule_add >/dev/null 2>&1
      INTERFACE='--interface CloudflareWARP' && ip4_info
      [ "$L" = C ] && COUNTRY4=$(translate "$COUNTRY4")
      info " $(text_eval 169)\n $(text_eval 62) "
    else
      proxy_info
      info " $(text 27): $PROXYSOCKS5\n WARP$AC IPv4: $PROXYIP $PROXYCOUNTRY $PROXYASNORG\n $(text_eval 62) "
    fi
    exit 0
  else
    if [ "$ACCOUNT_TYPE" = free ]; then
      if [ "$UPDATE_ACCOUNT" = wgcf ]; then
        OPTION=n && net
      else
        systemctl stop wireproxy; sleep 2
        wireproxy_onoff
        TYPE=' free' && info " $(text_eval 62) "
      fi
      exit 0
    fi
    until [ -e /etc/wireguard/account-temp.toml ] >/dev/null 2>&1; do
      /usr/bin/wgcf register --accept-tos --config /etc/wireguard/account-temp.toml >/dev/null 2>&1 && break
    done
    if [ -e /etc/wireguard/account-temp.toml ]; then
      until [ -e /etc/wireguard/profile-temp.conf ]; do
        /usr/bin/wgcf generate --config /etc/wireguard/account-temp.toml --profile /etc/wireguard/profile-temp.conf >/dev/null 2>&1
      done
    fi
    sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/profile-temp.conf)#; 3s#.*#$(sed -ne 3p /etc/wireguard/profile-temp.conf)#; 4s#.*#$(sed -ne 4p /etc/wireguard/profile-temp.conf)#" /etc/wireguard/wgcf.conf
    rm -f /etc/wireguard/profile-temp.conf /etc/wireguard/info.log
    if [ "$UPDATE_ACCOUNT" = wgcf ]; then
      wg-quick down wgcf >/dev/null 2>&1
      OPTION=n && net
    else
      sed -i "s#PrivateKey.*#PrivateKey = $(grep "PrivateKey.*" /etc/wireguard/wgcf.conf | sed "s#PrivateKey = ##g")#g" /etc/wireguard/proxy.conf
      systemctl stop wireproxy; sleep 2
      wireproxy_onoff
      TYPE=' free' && info " $(text_eval 62) "
    fi
    mv -f /etc/wireguard/account-temp.toml /etc/wireguard/wgcf-account.toml
    exit 0
  fi
}

# 更换为 WARP+ 账户
change_to_plus() {
  update_license
  if [ "$UPDATE_ACCOUNT" = client ]; then
    [[ "$ACCOUNT" =~ $LICENSE ]] && KEY_LICENSE='License' && error " $(text_eval 31) "
    [[ $(warp-cli --accept-tos settings) =~ WarpProxy ]] && CLIENT_PROXY=1
    hint "\n $(text 35) \n"
    warp-cli --accept-tos delete >/dev/null 2>&1
    [ "$CLIENT_PROXY" != 1 ] && rule_del >/dev/null 2>&1
    warp-cli --accept-tos register >/dev/null 2>&1 &&
    [ -n "$LICENSE" ] && LICENSE_STATUS=$(warp-cli --accept-tos set-license "$LICENSE")
    sleep 1
    [[ "$LICENSE_STATUS" =~ 'Too many devices' ]] && warning " $(text_eval 36) "
    ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null)
    unset AC && TYPE=' free' && [[ "$ACCOUNT" =~ Limited ]] && AC='+' && TYPE='+' && echo "$LICENSE" > /etc/wireguard/license && CHECK_TYPE=1 && check_quota
    if [ "$CLIENT_PROXY" != 1 ]; then
      rule_add >/dev/null 2>&1
      INTERFACE='--interface CloudflareWARP' && ip4_info
      [ "$L" = C ] && COUNTRY4=$(translate "$COUNTRY4")
      [ "$TYPE" = '+' ] && CLIENT_PLUS="$(text 63): $QUOTA"
      info " $(text_eval 169)\n $(text_eval 62)\n $CLIENT_PLUS \n"
    else
      proxy_info
      [ "$TYPE" = '+' ] && CLIENT_PLUS="$(text 63): $QUOTA"
      info " $(text 27): $PROXYSOCKS5\n WARP$TYPE IPv4: $PROXYIP $PROXYCOUNTRY $PROXYASNORG\n $(text_eval 62)\n $CLIENT_PLUS \n"
    fi
  else
    # 如现正使用着 WARP+ 账户，并且新输入的 License 也与现一样的话，脚本退出
    [ "$ACCOUNT_TYPE" = + ] && grep -q "$LICENSE" /etc/wireguard/wgcf-account.toml && KEY_LICENSE='License' && error " $(text_eval 31) "
    hint "\n $(text 35) \n"
    cp -f /etc/wireguard/wgcf-account.toml /etc/wireguard/account-temp.toml || exit 1
    sed -i "s#license_key.*#license_key = \'$LICENSE\'#g" /etc/wireguard/account-temp.toml
    wgcf update --name "$NAME" --config /etc/wireguard/account-temp.toml > /etc/wireguard/info-temp.log 2>&1
    # 升级时回显 429 说明触发反滥用风控, 还有 404 Not Found / TimeOut / timed out 等情况，可以通过不停的申请来处理; 回显 400 说明使用的终端设置超过5台, 维持原账户处理
    while grep -qisE "429 Too Many Requests|404 Not Found|time.*out" /etc/wireguard/info-temp.log; do
      wgcf update --name "$NAME" --config /etc/wireguard/account-temp.toml > /etc/wireguard/info-temp.log 2>&1
    done
    if grep -qs "400 Bad Request" /etc/wireguard/info-temp.log; then
      rm -f /etc/wireguard/account-temp.toml /etc/wireguard/info-temp.log
      warning " $(text_eval 36) " && OPTION=n && net
      exit 1
    elif grep -qs "Account type  : free" /etc/wireguard/info-temp.log; then
      rm -f /etc/wireguard/account-temp.toml /etc/wireguard/info-temp.log
      warning " $(text_eval 42) "
      if [ "$UPDATE_ACCOUNT" = wgcf ]; then
        OPTION=n && net
      else
        proxy_info
        TYPE=$AC2
        if [ "$TYPE" = plus ]; then
          info " $(text 27): $PROXYSOCKS52\n WARP$TYPE IPv4: $PROXYIP2 $PROXYCOUNTRY2 $PROXYASNORG2\n $(text_eval 62)\n $(text 25): $(grep 'Device name' /etc/wireguard/info.log | awk '{ print $NF }')\n $(text 63): $QUOTA "
        else
          info " $(text 27): $PROXYSOCKS52\n WARP$TYPE IPv4: $PROXYIP2 $PROXYCOUNTRY2 $PROXYASNORG2\n $(text_eval 62) "
        fi
      fi
      exit 1
    fi

    mv /etc/wireguard/info-temp.log /etc/wireguard/info.log
    if [ -e /etc/wireguard/account-temp.toml ]; then
      until [ -e /etc/wireguard/profile-temp.conf ]; do
        wgcf generate --config /etc/wireguard/account-temp.toml --profile /etc/wireguard/profile-temp.conf >/dev/null 2>&1
      done
    fi
    
    if [ "$UPDATE_ACCOUNT" = wgcf ]; then
      wg-quick down wgcf >/dev/null 2>&1
      sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/profile-temp.conf)#; 3s#.*#$(sed -ne 3p /etc/wireguard/profile-temp.conf)#; 4s#.*#$(sed -ne 4p /etc/wireguard/profile-temp.conf)#" /etc/wireguard/wgcf.conf
      rm -f /etc/wireguard/profile-temp.conf
      OPTION=n && net
      info " $(text_eval 62)\n $(text 25): $(grep 'Device name' /etc/wireguard/info.log | awk '{ print $NF }')\n $(text 63): $QUOTA "
    else
      systemctl stop wireproxy; sleep 2
      sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/profile-temp.conf)#; 3s#.*#$(sed -ne 3p /etc/wireguard/profile-temp.conf)#; 4s#.*#$(sed -ne 4p /etc/wireguard/profile-temp.conf)#" /etc/wireguard/wgcf.conf
      sed -i "s#PrivateKey.*#PrivateKey = $(grep "PrivateKey.*" /etc/wireguard/wgcf.conf | sed "s#PrivateKey = ##g")#g" /etc/wireguard/proxy.conf
      rm -f /etc/wireguard/profile-temp.conf
      wireproxy_onoff
      info " $(text_eval 62) "
    fi
    mv -f /etc/wireguard/account-temp.toml /etc/wireguard/wgcf-account.toml
  fi
}    

# 更换为 Teams 账户
change_to_teams() {
  input_url
  grep -q "$PRIVATEKEY" /etc/wireguard/wgcf.conf && KEY_LICENSE='Private key' && error " $(text_eval 31) "
  if grep -qiw "y" <<< "$CONFIRM"; then
    cp -f /etc/wireguard/wgcf.conf{,.bak}
    echo "$TEAMS" > /etc/wireguard/info-temp.log 2>&1
    if [ "$UPDATE_ACCOUNT" = wgcf ]; then
      wg-quick down wgcf >/dev/null 2>&1
      teams_change
      OPTION=n && net
      [ -e /etc/wireguard/info-temp.log ] && mv -f /etc/wireguard/info-temp.log /etc/wireguard/info.log
      [[ $(curl -ks4 https://www.cloudflare.com/cdn-cgi/trace | grep warp | sed "s/warp=//g") = plus || $(curl -ks6 https://www.cloudflare.com/cdn-cgi/trace | grep warp | sed "s/warp=//g") = plus ]] && rm -f /etc/wireguard/wgcf.conf.bak && TYPE=' teams' && info " $(text_eval 62) "
    else
      systemctl stop wireproxy; sleep 2
      teams_change

      sed -i "s#PrivateKey.*#PrivateKey = $PRIVATEKEY#g" /etc/wireguard/proxy.conf
      [ -e /etc/wireguard/info-temp.log ] && mv -f /etc/wireguard/info-temp.log /etc/wireguard/info.log
      wireproxy_onoff
      [[ $(eval echo "\$(curl -sx socks5h://localhost:$(ss -nltp | grep wireproxy | awk '{print $(NF-2)}'  | cut -d: -f2) https://www.cloudflare.com/cdn-cgi/trace)") =~ plus ]] && rm -f /etc/wireguard/wgcf.conf.bak && TYPE=' teams' && info " $(text_eval 62) "
    fi
  fi
}

# 免费 WARP 账户升级 WARP+ 账户
update() {
  wgcf_wireproxy() {
    [ ! -e /etc/wireguard/wgcf-account.toml ] && error " $(text 59) "
    [ ! -e /etc/wireguard/wgcf.conf ] && error " $(text 60) "

    CHANGE_DO0() { [ "$OPTION" != a ] && unset CHOOSE_TYPE && menu || exit; }
    CHANGE_DO1() { change_to_free; }
    CHANGE_DO2() { change_to_plus; }
    CHANGE_DO3() { change_to_teams; }

    # 判断现 WGCF 账户类型: free, plus, teams，如果是 plus，查 WARP+ 余额流量
    [ -z "$ACCOUNT_TYPE" ] && ACCOUNT_TYPE=free && CHANGE_TYPE=$(text 174) &&
    [ -e /etc/wireguard/info.log ] && ACCOUNT_TYPE=teams && CHANGE_TYPE=$(text 175) &&
    grep -q 'Device name' /etc/wireguard/info.log && ACCOUNT_TYPE='+' && CHANGE_TYPE=$(text 176) && check_quota && PLUS_QUOTA="\\n $(text 63): $QUOTA"

    if [ -z "$CHOOSE_TYPE" ]; then
      hint "\n $(text_eval 173)"
      [ "$OPTION" != a ] && hint " 0. $(text 49) \n" || hint " 0. $(text 76) \n"
      reading " $(text 50) " CHOOSE_TYPE
    fi
  
    # 输入必须是数字且少于等于3
    if [[ "$CHOOSE_TYPE" = [0-3] ]]; then
      CHANGE_DO$CHOOSE_TYPE
    else
      warning " $(text 51) [0-3] " && unset CHOOSE_TYPE && sleep 1 && update
    fi
  }

  wireproxy_account() {
    UPDATE_ACCOUNT=wireproxy
    wgcf_wireproxy
  }

  wgcf_account() {
    UPDATE_ACCOUNT=wgcf
    wgcf_wireproxy
  }

  client_account() {
    UPDATE_ACCOUNT=client
    [ "$ARCHITECTURE" = arm64 ] && error " $(text 101) "
    [ -n "$URL" ] && unset CHOOSE_TYPE && warning "\n $(text 9) "

    CHANGE_DO0() { menu; }
    CHANGE_DO1() { change_to_free; }
    CHANGE_DO2() { change_to_plus; }

    # 判断现 WGCF 账户类型: free, plus，如果是 plus，查 WARP+ 余额流量
    ACCOUNT_TYPE=free && CHANGE_TYPE=$(text 177)
    ACCOUNT=$(warp-cli --accept-tos account 2>/dev/null)
    [[ "$ACCOUNT" =~ Limited ]] && ACCOUNT_TYPE='+' && CHANGE_TYPE=$(text 178) && CHECK_TYPE=1 && check_quota && PLUS_QUOTA="$(text 63): $QUOTA"

    if [ -z "$CHOOSE_TYPE" ]; then
      hint "\n $(text_eval 173) \n"
      [ "$OPTION" != a ] && hint " 0. $(text 49) \n" || hint " 0. $(text 76) \n"
      reading " $(text 50) " CHOOSE_TYPE
    fi

    # 输入必须是数字且少于等于2
    if [[ "$CHOOSE_TYPE" = [0-2] ]]; then
      CHANGE_DO$CHOOSE_TYPE
    else
      warning " $(text 51) [0-2] " && unset CHOOSE_TYPE && sleep 1 && update
    fi
  }

  # 根据 WARP interface 、 Client 和 WirePorxy 的安装情况判断升级的对象
  INSTALL_CHECK=("wg-quick" "warp-cli" "wireproxy")
  CASE_RESAULT=("0 0 0" "0 0 1" "0 1 0" "0 1 1" "1 0 0" "1 0 1" "1 1 0" "1 1 1")
  SHOW_CHOOSE=("$(text 150)" "" "" "$(text 151)" "" "$(text 152)" "$(text 153)" "$(text 154)")
  ACCOUNT1=("" "wireproxy_account" "client_account" "client_account" "wgcf_account" "wgcf_account" "wgcf_account" "wgcf_account")
  ACCOUNT2=("" ""  "" "wireproxy_account" "" "wireproxy_account" "client_account" "client_account")
  ACCOUNT3=("" ""  "" "" "" "" "" "wireproxy_account")

  for ((c=0; c<${#INSTALL_CHECK[@]}; c++)); do
    [ $(type -p ${INSTALL_CHECK[c]}) ] && INSTALL_RESULT[c]=1 || INSTALL_RESULT[c]=0
  done

  for ((d=0; d<${#CASE_RESAULT[@]}; d++)); do
    [[ "${INSTALL_RESULT[@]}" = "${CASE_RESAULT[d]}" ]] && break
  done

  case "$d" in
    0 ) error " $(text 150) " ;;
    1|2|4 ) ${ACCOUNT1[d]} ;;
    * ) hint " ${SHOW_CHOOSE[d]} " && reading " $(text 50) " MODE
        case "$MODE" in
          [1-3] ) $(eval echo "\${ACCOUNT$MODE[d]}") ;;
          * ) warning " $(text 51) [1-3] "; sleep 1; update ;;
        esac ;;
  esac
}

# 判断当前 WARP 网络接口及 Client 的运行状态，并对应的给菜单和动作赋值
menu_setting() {
  if [[ "$CLIENT" -gt 1 || "$WIREPROXY" -gt 0 ]]; then
    [ "$CLIENT" -lt 3 ] && OPTION1="$(text 88)" || OPTION1="$(text 89)"
    [ "$WIREPROXY" -lt 2 ] && OPTION2="$(text 163)" || OPTION2="$(text 164)"
    OPTION3="$(text 143)"; OPTION4="$(text 78)"

    ACTION1() { proxy_onoff; }; ACTION2() { wireproxy_onoff; }; ACTION3() { change_port; }; ACTION4() { update; };

  else
    check_stack
    case "$m" in
      [0-2] ) OPTION1="$(text_eval 66)"; OPTION2="$(text_eval 67)"; OPTION3="$(text_eval 68)"
              ACTION1() { CONF=${CONF1[n]}; install; }; ACTION2() { CONF=${CONF2[n]}; install; }; ACTION3() { CONF=${CONF3[n]}; install; } ;;
        
      * ) OPTION1="$(text_eval 141)"; OPTION2="$(text_eval 142)"; OPTION3="$(text 78)"
          ACTION1() { stack_switch; }; ACTION2() { stack_switch; }; ACTION3() { update; } ;;
    esac
  fi

  [ -e /etc/dnsmasq.d/warp.conf ] && IPTABLE_INSTALLED="$(text 92)"
  [ -n "$(wg 2>/dev/null)" ] && OPTION4="$(text 77)" || OPTION4="$(text 71)"

  OPTION5="$CLIENT_INSTALLED$AMD64_ONLY$(text 82)"; OPTION6="$(text 123)"; OPTION7="$(text 72)"; OPTION8="$(text 74)"; OPTION9="$(text 73)"; OPTION10="$(text 75)";
  OPTION11="$(text 80)"; OPTION12="$IPTABLE_INSTALLED$(text 138)"; OPTION13="$WIREPROXY_INSTALLED$(text 148)"; OPTION14="$CLIENT_INSTALLED$AMD64_ONLY$(text 168)"; OPTION0="$(text 76)"

  ACTION4() { OPTION=o; onoff; }
  ACTION5() { proxy; }; ACTION6() { change_ip; }; ACTION7() { uninstall; }; ACTION8() { plus; }; ACTION9() { bbrInstall; }; ACTION10() { ver; }; 
  ACTION11() { bash <(curl -sSL https://raw.githubusercontent.com/fscarmen/warp_unlock/main/unlock.sh) -$L; }; 
  ACTION12() { ANEMONE=1 ;install; }; 
  ACTION13() { OCTEEP=1; install; };
  ACTION14() { LUBAN=1; proxy; };
  ACTION0() { exit; }

  [ -e /etc/wireguard/info.log ] && TYPE=' Teams' && grep -sq 'Device name' /etc/wireguard/info.log 2>/dev/null && check_quota && TYPE='+' && PLUSINFO="$(text 25): $(grep 'Device name' /etc/wireguard/info.log 2>/dev/null | awk '{ print $NF }')\t $(text 63): $QUOTA"
  }

# 显示菜单
menu() {
  clear
  hint " $(text 16) "
  echo -e "======================================================================================================================\n"
  info " $(text 17):$VERSION\t $(text 18):$(text 1)\n $(text 19):\n\t $(text 20):$SYS\n\t $(text 21):$(uname -r)\n\t $(text 22):$ARCHITECTURE\n\t $(text 23):$VIRT "
  info "\t IPv4: $WAN4 $WARPSTATUS4 $COUNTRY4  $ASNORG4 "
  info "\t IPv6: $WAN6 $WARPSTATUS6 $COUNTRY6  $ASNORG6 "
  case "$TRACE4$TRACE6" in
    *plus* ) info "\t $(text_eval 114)\t $PLUSINFO " ;;
    *on* ) info "\t $(text 115) " ;;
  esac
  [ "$PLAN" != 3 ] && info "\t $(text 116) "
  case "$CLIENT" in
    0 ) info "\t $(text 112) " ;;
    1 ) info "\t $(text_eval 113) " ;;
    3 ) info "\t WARP$AC $(text 24)\t $(text 27): $PROXYSOCKS5\n\t WARP$AC IPv4: $PROXYIP $PROXYCOUNTRY $PROXYASNORG " ;;
    5 ) info "\t WARP$AC $(text 24)\t $(text_eval 169) " ;;
  esac
  case "$WIREPROXY" in
    0 ) info "\t $(text 160) " ;;
    1 ) info "\t $(text 161) " ;;
    2 ) info "\t WARP$AC2 $(text 159)\t $(text 27): $PROXYSOCKS52\n\t WARP$AC2 IPv4: $PROXYIP2 $PROXYCOUNTRY2 $PROXYASNORG2 " ;;
  esac
  grep -q '+' <<< $AC$AC2 && info "\t $(text 63): $QUOTA "
   echo -e "\n======================================================================================================================\n"
  hint " 1.  $OPTION1\n 2.  $OPTION2\n 3.  $OPTION3\n 4.  $OPTION4\n 5.  $OPTION5\n 6.  $OPTION6\n 7.  $OPTION7\n 8.  $OPTION8\n 9.  $OPTION9 \n 10. $OPTION10\n 11. $OPTION11\n 12. $OPTION12\n 13. $OPTION13\n 14. $OPTION14\n 0.  $OPTION0\n "
  reading " $(text 50) " CHOOSE1
        
  # 输入必须是数字且少于等于最大可选项
  MAX_CHOOSE=14
  if grep -qE "^[0-9]{1,2}$" <<< $CHOOSE1 && [ "$CHOOSE1" -le "$MAX_CHOOSE" ]; then
    ACTION$CHOOSE1
  else
    warning " $(text 51) [0-$MAX_CHOOSE] " && sleep 1 && menu
  fi
}

# 传参选项 OPTION: 1=为 IPv4 或者 IPv6 补全另一栈WARP; 2=安装双栈 WARP; u=卸载 WARP; b=升级内核、开启BBR及DD; o=WARP开关；p=刷 WARP+ 流量; 其他或空值=菜单界面
[ "$1" != '[option]' ] && OPTION=$(tr 'A-Z' 'a-z' <<< "$1")

# 参数选项 URL 或 License 或转换 WARP 单双栈
if [ "$2" != '[lisence]' ]; then
  if [[ "$2" =~ http ]]; then CHOOSE_TYPE=3 && URL=$2
  elif [[ "$2" =~ ^[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}$ ]]; then CHOOSE_TYPE=2 && LICENSE=$2
  elif [[ "$1" = s && "$2" = [46Dd] ]]; then PRIORITY_SWITCH=$(tr 'A-Z' 'a-z' <<< "$2")
  elif [[ "$2" =~ ^[A-Za-z]{2}$ ]]; then EXPECT=$2
  fi
fi

# 自定义 WARP+ 设备名
NAME=$3

# 主程序运行 1/3
statistics_of_run-times
select_language
check_operating_system

# 设置部分后缀 1/3
case "$OPTION" in
  h ) help; exit 0 ;;
  p ) plus; exit 0 ;;
  i ) change_ip; exit 0 ;;
  s ) stack_priority; result_priority; exit 0 ;;
esac

# 主程序运行 2/3
check_root_virt

# 设置部分后缀 2/3
case "$OPTION" in
  b ) bbrInstall; exit 0 ;;
  u ) uninstall; exit 0 ;;
  v ) ver; exit 0 ;;
  n ) net; exit 0 ;;
  o ) onoff; exit 0 ;;
  r ) proxy_onoff; exit 0 ;;
  y ) wireproxy_onoff; exit 0 ;;
esac

# 主程序运行 3/3
check_dependencies
check_system_info
menu_setting

# 设置部分后缀 3/3
case "$OPTION" in
# 在已运行 Linux Client 前提下，不能安装 WARP IPv4 或者双栈网络接口。如已经运行 WARP ，参数 4,6,d 从原来的安装改为切换
[46d] ) if [ -e /etc/wireguard/wgcf.conf ]; then
          SWITCHCHOOSE="$(tr 'a-z' 'A-Z' <<< "$OPTION")"
          stack_switch
        else
          case "$OPTION" in
            4 ) [[ $CLIENT = [35] ]] && error " $(text 110) "
                CONF=${CONF1[n]} ;; 
            6 ) CONF=${CONF2[n]} ;;
            d ) [[ $CLIENT = [35] ]] && error " $(text 110) "
                CONF=${CONF3[n]} ;;
          esac
          install
        fi ;;
c ) proxy ;;
l ) LUBAN=1 && proxy ;;
a ) update ;;
e ) stream_solution ;;
w ) wireproxy_solution ;;
* ) menu ;;
esac