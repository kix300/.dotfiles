import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar"
import Applauncher from "./widget/Applauncher"


App.start({
    instanceName: "launcher",
    css: style,
    main: Applauncher,
})

App.start({
    css: style,
    instanceName: "js",
    requestHandler(request, res) {
        print(request)
        res("ok")
    },
    main: () => App.get_monitors().map(Bar),
})
