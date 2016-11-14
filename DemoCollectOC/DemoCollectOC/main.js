require('GifDisplayViewController,UIColor,NSString')

defineClass('GifDisplayViewController', {
  viewDidLoad: function() {
    self.super().viewDidLoad();
    self.setTestString('test');
    self.view().setBackgroundColor(UIColor.grayColor())
    self.displayGifView()
    self.testString(NSString.stringWithFormat("TTTest%@", self.testString()))
  }
})
