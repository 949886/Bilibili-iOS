//
//  URLConstants.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#ifndef URLConstants_h
#define URLConstants_h

/* API GET */

#define BILIBILI_CAPTCHA @"https://passport.bilibili.com/captcha"

#define BILIBILI_VIDEO_INFO @"http://app.bilibili.com/x/view"
#define BILIBILI_VIDEO_COMMENTS @"http://api.bilibili.com/feedback"
#define BILIBILI_VIDEO_BP @"http://www.bilibili.com/widget/ajaxGetBP"       //B币
#define BILIBILI_VIDEO_PLAYURL @"http://interface.bilibili.com/playurl"     //暂不可用
#define BILIBILI_VIDEO_PLAYURL_M @"http://www.bilibili.com/m/html5"        //低清开放接口

#define BILIBILI_BANGUMI_INFO @"http://bangumi.bilibili.com/api/season_v3"
#define BILIBILI_BANGUMI_GET_BY_TAG @"http://bangumi.bilibili.com/api/get_season_by_tag_v2"

#define BILIBILI_DANMAKU @"http://comment.bilibili.com/"

#define BILIBILI_USER_INFO @"http://api.bilibili.cn/userinfo"
#define BILIBILI_USER_ATTENTION_LIST @"http://space.bilibili.com/ajax/friend/GetAttentionList"
#define BILIBILI_USER_FANS_LIST @"http://space.bilibili.com/ajax/friend/GetFansList"
#define BILIBILI_USER_SUBSCRIBED_BANGUMI @"http://space.bilibili.com/ajax/bangumi/getlist"
#define BILIBILI_USER_SUBSCRIBED_TAG @"http://space.bilibili.com/ajax/tags/getsublist"
#define BILIBILI_USER_FAVORIATE_BOX_LIST @"http://space.bilibili.com/ajax/fav/getboxlist"
#define BILIBILI_USER_SUBMITTED_VIDEO @"http://space.bilibili.com/ajax/member/getSubmitVideos"
#define BILIBILI_USER_HISTORY @"http://api.bilibili.com/x/v2/history"

#define BILIBILI_BANNER @"http://app.bilibili.com/x/banner/old"


#define BILIBILI_LIVE_HOME @"http://live.bilibili.com/AppIndex/home"

#define BILIBILI_IPHONE_RECOMMEND_HOME @"http://app.bilibili.com/x/v2/show"
#define BILIBILI_IPHONE_BANGUMI_HOME @"http://bangumi.bilibili.com/api/app_index_page_v3"
#define BILIBILI_IPHONE_BANGUMI_RECOMMEND @"http://bangumi.bilibili.com/api/bangumi_recommend"

#define BILIBILI_IPAD_RECOMMEND_HOME @"https://app.bilibili.com/x/show"
#define BILIBILI_IPAD_BANGUMI_HOME @"http://bangumi.bilibili.com/api/app_index_page"
#define BILIBILI_IPAD_BANGUMI_TIMELINE @"http://bangumi.bilibili.com/jsonp/timeline_v2"
#define BILIBILI_IPAD_BANGUMI_TAGS @"http://bangumi.bilibili.com/api/tags"
#define BILIBILI_IPAD_BANGUMI_CONCERNED @"http://bangumi.bilibili.com/api/get_concerned_season"

/* API POST */

#define BILIBILI_ADD_REPLY @"http://api.bilibili.com/x/reply/add"
#define BILIBILI_ADD_FAVOURIATE_VIDEO @"http://api.bilibili.com/x/favourite/video/add"

#define BILIBILI_DELETE_FAVOURIATE_VIDEO @"http://api.bilibili.com/x/favourite/video/del"

/* JJ */
#define BILIBILIJJ_AV2CID @"http://www.bilibilijj.com/Api/AvToCid/"

#endif /* URLConstants_h */

//E.G. (GET)



//BILIBILI_VIDEO_INFO http://app.bilibili.com/x/v2/view?access_key=fd8aef972c053d0eb920680935482fc6&actionKey=appkey&aid=6024746&appkey=85eb6835b0a1034e&build=3600&device=phone&mobi_app=iphone&platform=ios&sign=f0696237560b7698c474e329a95f91c0&ts=1472409128
//BILIBILI_VIDEO_PLAYURL http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&_aid=5216011&cid=8477109
//BILIBILI_VIDEO_PLAYURL_M http://www.bilibili.com/m/html5?aid=5976369&page=1


//BILIBILI_BANGUMI 新番连载 http://bangumi.bilibili.com/api/get_season_by_tag_v2?access_key=60b056cf4525dda82fd0880d103bce85&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3380&device=pad&indexType=0&mobi_app=iphone&page=1&pagesize=6&platform=ios&sign=866a409ead790ea4f763afe5b65fd6de&tag_id=84&ts=1467466355
//BILIBILI_BANGUMI 完结动画 http://bangumi.bilibili.com/api/get_season_by_tag_v2?access_key=60b056cf4525dda82fd0880d103bce85&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3380&device=pad&indexType=0&mobi_app=iphone&page=1&pagesize=6&platform=ios&sign=d96814ff75104372f0b21eaf9173f6d0&tag_id=85&ts=1467466355

//BILIBILI_USER_HISTORY 用户观看历史 http://api.bilibili.com/x/v2/history?access_key=0fbfd318ecae0ef6d4f75847284dd7b6&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3430&device=pad&mobi_app=iphone&platform=ios&pn=1&ps=30&sign=28edb235650cd8479f25528ead12d196&ts=1467474771

//BILIBILI_BANNER 图片轮播横幅 http://app.bilibili.com/x/banner/old?screen=xxhdpi&build=402003

//BILIBILI_IPHONE_RECOMMEND_HOME http://app.bilibili.com/x/v2/show?access_key=99d02371222f07c14779faf9193c7bdf&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3430&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=64d5c90ce44fceb8dd3dfdd12a0c4193&ts=1467670945&warm=1
//BILIBILI_IPHONE_LIVE_HOME http://live.bilibili.com/AppIndex/home?access_key=99d02371222f07c14779faf9193c7bdf&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3430&device=phone&mobi_app=iphone&platform=ios&scale=2&sign=54b5fe76ce29f5f4052941a61a158a21&ts=1467674346
//BILIBILI_IPHONE_BANGUMI_HOME http://bangumi.bilibili.com/api/app_index_page_v3?access_key=99d02371222f07c14779faf9193c7bdf&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3430&device=phone&mobi_app=iphone&platform=ios&sign=9d51ba8e1a1fe1735699348d4d0246f3&ts=146767392
//BILIBILI_IPHONE_BANGUMI_RECOMMEND http://bangumi.bilibili.com/api/bangumi_recommend?access_key=99d02371222f07c14779faf9193c7bdf&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3430&cursor=1464429600535&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=8eb5f75ab938a2167b8bc4a3812e3e95&ts=1467673929

//BILIBILI_IPAD_RECOMMEND_HOME https://app.bilibili.com/x/show?access_key=0fbfd318ecae0ef6d4f75847284dd7b6&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3430&channel=appstore&device=pad&mobi_app=iphone&plat=2&platform=ios&sign=2775a4fc52e02f1d8a98e0e334de758b&ts=1467671646
//BILIBILI_IPAD_RECOMMEND_HOME_REFRESH_HOT http://app.bilibili.com/x/show/hot?access_key=0fbfd318ecae0ef6d4f75847284dd7b6&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3440&channel=appstore&device=pad&mobi_app=iphone&plat=2&platform=ios&rand=7&sign=bf7aa020e52b5c214edc2dce71d45a94&ts=1468511344
//BILIBILI_IPAD_LIVE_HOME http://live.bilibili.com/AppIndex/home?access_key=bb414b00fc0465fdd879e3ac09f80be8&actionKey=appkey&appkey=27eb53fc9058f8c3&build=101220&device=pad&mobi_app=white&platform=ios&scale=2&sign=6f76304fcb4ed57c2b32a353eba1afc9&ts=1467674474
//BILIBILI_IPAD_BANGUMI_HOME http://bangumi.bilibili.com/api/app_index_page?actionKey=appkey&appkey=27eb53fc9058f8c3&build=101220&device=pad&mobi_app=white&platform=ios&sign=1c152ba13d3cbd47656525a610579f0e&ts=1467468875
//BILIBILI_IPAD_BANGUMI_TIMELINE http://bangumi.bilibili.com/jsonp/timeline_v2?_device=ipad&_hwid=4d70e86e50b6bfe8&_ulv=10000&appkey=27eb53fc9058f8c3&appver=101220&btype=2&build=101220&platform=ios&type=json&sign=f544944ea032f0f0c8ed17a522fe7816
//BILIBILI_IPAD_BANGUMI_TAGS http://bangumi.bilibili.com/api/tags?access_key=bb414b00fc0465fdd879e3ac09f80be8&actionKey=appkey&appkey=27eb53fc9058f8c3&build=101220&device=pad&mobi_app=white&page=1&pagesize=30&platform=ios&sign=98b8af4dd6e12b8f887d81b71f7371be&ts=1467674709
//BILIBILI_IPAD_BANGUMI_CONCERNED http://bangumi.bilibili.com/api/get_concerned_season?access_key=bb414b00fc0465fdd879e3ac09f80be8&actionKey=appkey&appkey=27eb53fc9058f8c3&build=101220&device=pad&mobi_app=white&page=1&pagesize=30&platform=ios&sign=d2994ec7e8ec357f2a048a309557e2a7&taid=&ts=1467674625

//http://api.bilibili.com/x/favourite/video/add?_device=iphone&_hwid=6bf45077d7cdf09c&_ulv=10000&access_key=99d02371222f07c14779faf9193c7bdf&aid=5213222&appkey=27eb53fc9058f8c3&appver=3440&build=3440&platform=ios&type=json&sign=1115d408016d2a9ac890bf60ff2223be
//http://api.bilibili.com/x/favourite/video/del?_device=iphone&_hwid=6bf45077d7cdf09c&_ulv=10000&access_key=99d02371222f07c14779faf9193c7bdf&aid=5213222&appkey=27eb53fc9058f8c3&appver=3440&build=3440&platform=ios&type=json&sign=1115d408016d2a9ac890bf60ff2223be

//IPONE 广告 http://app.bilibili.com/x/splash?build=3440&channel=appstore&height=1334&plat=1&width=750
//IPAD 广告 http://app.bilibili.com/x/splash?build=3440&channel=appstore&height=1536&plat=1&width=2048



