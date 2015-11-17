# SNRulerPicker
刻度尺选取控件

![image](http://7xk4w4.com1.z0.glb.clouddn.com/imgbase_20151117114906.gif)

## DEMO

```objc
self.rulerPicker = [[SNRulerPickerView alloc] initWithFrame:CGRectMake(17, 300, [UIScreen mainScreen].bounds.size.width-34, 132)];
[self.rulerPicker updateView:@"体重" unit:@"kg" minValue:25 maxValue:200 defaultValue:72.3];
[self.view addSubview:self.rulerPicker];
```

## License
FontAwesomeKit is available under the MIT license. See the LICENSE file for more information. Attribution isn't required but is much appreciated.

## About
rushairer@163.com