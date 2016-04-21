# KeyboardManager

1 实例化一个 KeyboardManager 

2 调用- (void)addInputView:(UIView *)inputView andWillScrollView:(UIView *)willScrollView; 添加想要滚动的UIView

3 正常情况下，输入框与键盘紧贴，设置 moreOffsetY 可以远离键盘

4 调用 - (void)moveToNextInputView:(UIView *)inputView; 移动到下一个输入框。ps:输入框必须按顺序 add
