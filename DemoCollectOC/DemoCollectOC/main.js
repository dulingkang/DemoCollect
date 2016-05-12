require('GifDisplayViewController, UIColor')

defineClass('GifDisplayViewController', {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.view().setBackgroundColor(UIColor.grayColor())
            self.displayGifView()
            }
            })