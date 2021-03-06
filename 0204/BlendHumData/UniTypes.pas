unit UniTypes;

interface

uses SysUtils, Classes,Windows;

type
  TListArray  = array [Ord('A')..Ord('Z') + 10 + 1] of TStrings;

  pTQuickInfo = ^TQuickInfo;
  TQuickInfo  = packed record
    sChrName  : string[16];
    nPosition : Cardinal;
  end;

  //size 124 ID.DB 数据头  
  TDBHeader = packed record
    sDesc: string[34]; //0x00    #
    n23: Integer; //0x23
    n28: Integer; //0x27
    n2C: Integer; //0x2B
    n30: Integer; //0x2F
    n34: Integer; //0x33
    n38: Integer; //0x37
    n3C: Integer; //0x3B
    n40: Integer; //0x3F
    n44: Integer; //0x43
    n48: Integer; //0x47
    n4B: Byte; //0x4B
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C 最后的索引 #
    dLastDate: TDateTime; //0x60           #
    nIDCount: Integer; //0x68 ID数量       #
    n6C: Integer; //0x6C
    nDeletedIdx: Integer; //0x70     := -1 #
    dUpdateDate: TDateTime; //0x74         # 
  end;
  pTDBHeader = ^TDBHeader;

  //人物数据头
  TDBHeader1 = packed record //Size 124
    sDesc: string[$23]; //0x00    36
    n24: Integer; //0x24
    n28: Integer; //0x28
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //最后退登日期
    nHumCount: Integer; //0x68
    n6C: Integer; //0x6C
    n70: Integer; //0x70
    dUpdateDate: TDateTime; //更新日期
  end;

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean; //是否删除
    nSelectID: Byte;   //ID
    boIsHero: Boolean; //是否英雄
    bt2: Byte;
    dCreateDate: TDateTime; //创建时间
    sName: string[15]; //角色名称   28
  end;
  pTRecordHeader = ^TRecordHeader;

{THumInfo}
  pTDBHum = ^TDBHum;
  TDBHum = packed record//FileHead  72字节   //Size 72
    Header: TRecordHeader;
    sChrName: string[14]; //角色名称   44
    sAccount: string[10]; //账号
    boDeleted: Boolean; //是否删除
    bt1: Byte; //未知
    dModDate: TDateTime;//操作日期
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否选择
    n6: array[0..5] of Byte;
  end;

  pTUserItem = ^TUserItem;
  TUserItem = record // 20080313 修改
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: array[0..20] of Byte;//附加属性  12-发光  13-自定义名称
  end;

  TOAbility = packed record
    Level: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    {btReserved1: Byte;//20081001 注释
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;}
    NG: Word;//20081001 当前内力值
    MaxNG: Word;//20081001 内力值上限
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word; //背包
    WearWeight: Byte;
    MaxWearWeight: Byte; //负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;

  pTNakedAbility=^TNakedAbility;
  TNakedAbility = packed record //Size 20
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;

  pTHumMagicInfo= ^THumMagicInfo;
  THumMagicInfo = record
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //当前持久值
  end;

  TUnKnow = array[0..29] of Byte;
  TStatusTime = array[0..11] of Word;
  TQuestUnit = Array[0..127] of Byte;
  TQuestFlag = array[0..127] of Byte;

  THumItems=Array[0..8] of TUserItem;
  THumAddItems=Array[9..13] of TUserItem;//支持斗笠 20080416
  TBagItems=Array[0..45] of TUserItem;
  THumMagic=Array[0..29] of THumMagicInfo;
  THumNGMagics = array[0..29] of THumMagicInfo;//内功技能 20081001
  pTHumNGMagics = ^THumNGMagics;//内功技能 20081001
  TStorageItems=Array[0..45] of TUserItem; //20071115
  TAddBagItems=Array[46..51] of TUSerItem;

  pTHumData = ^THumData;
  THumData = packed record {人物数据类 Size = 4402 预留N个变量 20081227}
    sChrName: string[14];//姓名
    sCurMap: string[16];//地图
    wCurX: Word;//坐标X
    wCurY: Word;//坐标Y
    btDir: Byte;//方向
    btHair: Byte;//头发
    btSex: Byte;//性别
    btJob: Byte;//职业
    nGold: Integer; //金币数
    Abil: TOAbility; //+40   人物其它属性
    wStatusTimeArr: TStatusTime; //+24 人物状态属性值，一般是持续多少秒
    sHomeMap: string[16];//Home 回城地图
    //btUnKnow1: Byte;//(20080404 未使用)
    wHomeX: Word;//Home X
    wHomeY: Word;//Home Y
    sDearName: string[14];//别名(配偶)
    sMasterName: string[14];//师傅名字
    boMaster: Boolean;//是否有徒弟
    btCreditPoint: Integer;//声望点 20080118
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];//仓库密码
    btReLevel: Byte;//转生等级
    btUnKnow2: array[0..2] of Byte;//0-是否开通元宝寄售(1-开通) 1-是否寄存英雄(1-存有英雄)
    BonusAbil: TNakedAbility;  //+20 奖金
    nBonusPoint: Integer;//奖励点
    nGameGold: Integer;//游戏币
    nGameDiaMond: Integer;//金刚石 20071226
    nGameGird:Integer;//灵符 20071226
    nGamePoint: Integer;//游戏点
    btGameGlory: Byte; //荣誉 20080511
    nPayMentPoint: Integer; //充值点
    N: Integer;//英雄的忠诚度(20080109)
    nPKPOINT: Integer;//PK点数
    btAllowGroup: Byte;//允许组队
    btF9: Byte;
    btAttatckMode: Byte;//攻击模式
    btIncHealth: Byte;//增加健康数
    btIncSpell: Byte;//增加攻击点
    btIncHealing: Byte;//增加治愈点
    btFightZoneDieCount: Byte;//在行会占争地图中死亡次数
    sAccount: string[10];//登录帐号
    //btEE: Byte;
    btEF: Byte;//英雄类型 0-白日门英雄 1-卧龙英雄 20080514
    boLockLogon: Boolean;//是否锁定登陆
    wContribution: Word;//贡献值
    nHungerStatus: Integer;//饥饿状态
    boAllowGuildReCall: Boolean; //是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[14];//英雄名称
    UnKnow: TUnKnow;//预留 array[0..39] of Byte; 0-3酿酒使用 20080620 4-饮酒时的度数 5-魔法盾等级
    QuestFlag: TQuestFlag; //脚本变量
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagic; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
    n_WinExp:integer;//累计经验 20080110
    n_UsesItemTick: Integer;//聚灵珠聚集时间 20080221
    nReserved: Integer; //酿酒的时间,即还有多长时间可以取回酒 20080620
    nReserved1: Integer; //当前药力值 20080623
    nReserved2: Integer; //药力值上限 20080623
    nReserved3: Integer; //使用药酒时间,计算长时间没使用药酒 20080623
    n_Reserved: Word;   //当前酒量值 20080622
    n_Reserved1: Word;  //酒量上限 20080622
    n_Reserved2: Word;  //当前醉酒度 20080623
    n_Reserved3: Word;  //药力值等级 20080623
    boReserved: Boolean; //是否请过酒 T-请过酒
    boReserved1: Boolean;//是否有卧龙英雄 20080519
    boReserved2: Boolean;//是否酿酒 T-正在酿酒 20080620
    boReserved3: Boolean;//人是否喝酒醉了 20080627
    m_GiveDate:Integer;//人物领取行会酒泉日期 20080625
    Exp66: LongWord;//酒气护体当前经验 20080625
    MaxExp66: LongWord;//酒气护体升级经验 20080625
    nExpSkill69: Integer;//内功当前经验 20080930
    HumNGMagics: THumNGMagics;//内功技能 20081001
    m_nReserved1: Word;//保留
    m_nReserved2: Word;//保留
    m_nReserved3: Word;//保留
    m_nReserved4: LongWord;//保留
    m_nReserved5: LongWord;//保留
    m_nReserved6: Integer;//保留
    m_nReserved7: Integer;//保留
  end;


  THumDataInfo = packed record //Size 3176
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;
  
//用户注册信息,即ID账号
  TUserEntry = packed record
    sAccount: string[10];//账号
    sPassword: string[10];//密码
    sUserName: string[20];//用户名
    sSSNo: string[14];  //身份证
    sPhone: string[14];//电话
    sQuiz: string[20];//问题1
    sAnswer: string[12];//答案1
    sEMail: string[40]; //邮箱
  end;

  TUserEntryAdd = packed record
    sQuiz2: string[20];//问题2
    sAnswer2: string[12];//答案2
    sBirthDay: string[10];//生日
    sMobilePhone: string[13];//移动电话
    sMemo: string[20];//备注一
    sMemo2: string[20];//备注二
  end;

//账号记录头   size 32
  TIDRecordHeader = packed record
    boDeleted: Boolean;//是否删除
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime; //创建时间
    UpdateDate: TDateTime; //最后登录时间
    sAccount: string[11]; //账号
  end;

  TAccountDBRecord = packed record  //size 328
    Header: TIDRecordHeader;//账号记录头
    UserEntry: TUserEntry;//ID账号信息1
    UserEntryAdd: TUserEntryAdd;//ID账号信息2
    nErrorCount: Integer;
    dwActionTick: LongWord;
    N: array[0..38] of Byte;
  end;

  TDealOffInfo = packed record //元宝寄售数据结构
    sDealCharName: string[14];//寄售人
    sBuyCharName: string[14];//购买人
    dSellDateTime: TDateTime;//寄售时间
    nSellGold: Integer;//交易的元宝数
    UseItems: array[0..9] of TUserItem;//物品
    N: Byte;//交易识标 0-正常 1-购买,但寄售人未得到元宝 2-购买人取消  3-交易结束(得到元宝)
  end;
  pTDealOffInfo = ^TDealOffInfo;

  TDearData = packed record//配偶数据(合区使用)
    sDearName: string[14];//配偶名
    sNewHumName: string[14];//新名字
  end;
  pTDearData = ^TDearData;

  TMasterData = packed record//师傅数据(合区使用)
    sName: string[14];//原名字
    sMasterName: string[14];//师傅名
    sNewHumName: string[14];//新名字
  end;
  pTMasterData = ^TMasterData;

  THeroData = packed record//英雄数据(合区使用)
    sHeroName: string[14];
    sNewHumName: string[14];
    sMasterName: string[14];
  end;
  pTHeroData = ^THeroData;

  TBigStorage = packed record //无限仓库数据结构
    boDelete: Boolean;
    sCharName: string[14];
    SaveDateTime: TDateTime;
    UseItems: TUserItem;
    nCount: Integer;
  end;
  pTBigStorage = ^TBigStorage;

  //文本合并数据结构 20080703
  TTxtData =  packed record
    nTxtTpye: Byte;//文本类型 0-普通文本(只有名字) 1-ini类型
    sFileName: string;//文本名(XXX.txt)
    sData:TList;//文本内容(保存类)
    boMakeOne: Boolean;
  end;
  pTTxtData = ^TTxtData;

  TTxtInfo =  packed record
    sHumName: string;//普通文本-玩家名字 ini文本-玩家名字,即节点
    sKeyword: String;//ini关键字,普通文本留空
    sIniValue: string;//ini值
  end;
  pTTxtInfo = ^TTxtInfo;

const
  DBFileDesc = '清客网络数据库文件 2008/12/20';
  sDBIdxHeaderDesc = '清客网络数据库索引文件 2008/12/20';

var
  boDataDBReady: Boolean; //0x004ADAF4
  boHumDBReady: Boolean;
  HumDB_CS: TRTLCriticalSection; //0x004ADACC
  g_boDataDBReady: Boolean; //20081128

function  GetFirstChar(const  AHzStr:  string):  string;
function  GetWWIndex(const S: string): Integer;
function  _Max14ReName(S: string; DefChar: Char): string;
function  _Max10ReName(S: string; DefChar: Char): string;

implementation

function  GetFirstChar(const  AHzStr:  string):  string;
const
   ChinaCode:  array[0..25,  0..1]  of  Integer  =  ((1601,  1636),
                                                     (1637,  1832),
                                                     (1833,  2077),
                                                     (2078,  2273),
                                                     (2274,  2301),
                                                     (2302,  2432),
                                                     (2433,  2593),
                                                     (2594,  2786),
                                                     (9999,  0000),
                                                     (2787,  3105),
                                                     (3106,  3211),
                                                     (3212,  3471),
                                                     (3472,  3634),
                                                     (3635,  3722),
                                                     (3723,  3729),
                                                     (3730,  3857),
                                                     (3858,  4026),
                                                     (4027,  4085),
                                                     (4086,  4389),
                                                     (4390,  4557),
                                                     (9999,  0000),
                                                     (9999,  0000),
                                                     (4558,  4683),
                                                     (4684,  4924),
                                                     (4925,  5248),
                                                     (5249,  5589));
var  
   i, j, HzOrd:  Integer;
begin  
   i  :=  1;
   while  i  <=  Length(AHzStr)  do  
    begin
      if  (AHzStr[i]  >=  #160)  and  (AHzStr[i  +  1]  >=  #160)  then
        begin
          HzOrd  :=  (Ord(AHzStr[i])  -  160)  *  100  +  Ord(AHzStr[i  +  1])  -  160;
          for  j  :=  0  to  25  do
            begin
              if  (HzOrd  >=  ChinaCode[j][0])  and  (HzOrd  <=  ChinaCode[j][1])  then
               begin
                Result  :=  Result  +  Char(Byte('A')  +  j);
                Break;
               end;
            end;
          Inc(i);
        end  else  Result  :=  Result  +  AHzStr[i];
      Inc(i);
    end;
  Result := UpperCase(Result);
end;

function GetWWIndex(const S: string): Integer;
var
  Str2: string;
begin
  Str2  :=  GetFirstChar(S);
  Result  := High(TListArray);
  if Str2 <> '' then
    begin
      Result := Ord(Str2[1]);
      if Result < 65 then
        Result := Result - 47 + 90;
    end;
  if Result > High(TListArray) - 1
    then Result := High(TListArray);
end;

function  _Max14ReName(S: string; DefChar: Char): string;
begin
  if Length(S) >= 14 then begin
    case ByteType(S, Length(S)) of
      mbSingleByte: S := Copy(S, 1, Length(S) - 1);
      mbLeadByte,
      mbTrailByte : S := Copy(S, 1, Length(S) - 2);
    end;
  end;
  Result  := S + DefChar;
end;

function  _Max10ReName(S: string; DefChar: Char): string;
begin
  if Length(S) >= 10 then
    begin
     case ByteType(S, Length(S)) of
       mbSingleByte: S := Copy(S, 1, Length(S) - 1);
       mbLeadByte,
       mbTrailByte : S := Copy(S, 1, Length(S) - 2);
     end;
    end;
  Result  := S + DefChar;
end;

end.

