# Example

10.17
添加滑动快进

写的示例代码方便下次直接用
1.工具类


//计算字符串长度
+(CGSize)calculateStringLenth:(NSString*)string withWidth:(CGFloat)width withFontSize:(NSInteger)font;

//颜色十六进制转换
+(UIColor *)getColor:(NSString *)hexColor;

//输入date 输出星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate withDateStr:(NSString*)dateStr;

//比较时间前后
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;

//计算日期提前或延后
+(NSString*)dateWithDays:(NSInteger)days;


+(NSString*)dateWithDays:(NSInteger)days frome:(NSString*)date;

//计算给定月份天数

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date with:(NSString*)datestr;


//计算给定月份第一天周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date with:(NSString*)datestr;


2.自定义按键的AVPlayer
