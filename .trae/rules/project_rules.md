# 项目概览

这是一个 Sony 智能电视的遥控器项目，项目的目标是实现对 Sony 智能电视的远程控制。

## RestAPI 文档地址
https://pro-bravia.sony.net/zhs/develop/integrate/rest-api/spec/getting-started/index.html

## 项目架构

采用SwiftUI + MVVM + Repository 架构，其中：

- SwiftUI 负责界面的构建和展示
- ViewModel 负责业务逻辑的处理和数据的管理
- Repository 负责数据的获取和存储
- APIService 负责Sony智能电视的RestAPI调用
- Network 使用Alamofire实现网络请求

以SwiftPackageManager管理项目依赖，项目依赖如下：

- Alamofire

## 项目模块

整体以底TabBar为导航，每个Tab对应一个模块，具有以下模块

- `RemoteControl`：负责远程控制的功能实现
- `Collection` 负责设备配对管理
- `Setting`：负责设置的功能实现
