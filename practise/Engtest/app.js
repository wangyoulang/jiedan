App({
  async onLaunch() {
    // 初始化共享云环境
    this.c1 = new wx.cloud.Cloud({
      resourceAppid: "wx3199c80279c7b8c3",  // 教育场景固定 AppID
      resourceEnv: "education-4gkyxpyc7aa37c34"  // 共享云环境 ID
    })
    
    // 等待初始化完成
    try {
      await this.c1.init()
      // 将云环境对象保存到全局变量
      this.globalData.cloudEnv = this.c1
    } catch (error) {
      console.error('云环境初始化失败：', error)
      wx.showToast({
        title: '系统初始化失败',
        icon: 'none'
      })
    }

    // 展示本地存储能力
    const logs = wx.getStorageSync('logs') || []
    logs.unshift(Date.now())
    wx.setStorageSync('logs', logs)

    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
      }
    })
  },
  
  globalData: {
    userInfo: null,
    cloudEnv: null  // 用于存储共享云环境对象
  }
}) 