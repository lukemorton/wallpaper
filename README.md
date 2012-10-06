# Wallpaper (an example app)

This is an example app using `sinatra` as a routing layer.
Please excuse the boiler plate in `app/lib` however I chose
to interact with `rack`s `request` and `response` objects
directly.

To get things running:

```
cd app
bundle install
rackup
```

## What's the point?

I wrote this example application to express a way of creating
apps that feels comfortable to me. Some goals of this layout:

 - Separating domain from application logic
 - Moving away from standard MVC project layout
 - Use of dependency injection where appropriate

## Thanks

I have quite a lot of thanks to give, I will assemble a list
soon :)

## Author

Luke Morton a.k.a. DrPheltRight

## License

MIT