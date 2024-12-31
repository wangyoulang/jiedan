Page({
  data: {
    hasUserInfo: false,
    userInfo: null
  },

  onLoad() {
    // 检查登录状态
    const userInfo = wx.getStorageSync('userInfo')
    if (userInfo) {
      this.setData({
        hasUserInfo: true,
        userInfo: userInfo
      })
    }
  },

  // 跳转到背单词页面
  goToLearnWords() {
    wx.navigateTo({
      url: '/pages/learn/learn'
    })
  },

  // 跳转到词库页面
  goToWordHistory() {
    wx.showActionSheet({
      itemList: ['认识的单词', '不认识的单词'],
      success: (res) => {
        if (res.tapIndex === 0) {
          wx.navigateTo({
            url: '/pages/known-words/known-words'
          })
        } else {
          wx.navigateTo({
            url: '/pages/unknown-words/unknown-words'
          })
        }
      }
    })
  },

  // 处理用户中心/登录
  handleUserCenter() {
    if (!this.data.hasUserInfo) {
      wx.getUserProfile({
        desc: '用于完善用户资料',
        success: (res) => {
          this.setData({
            hasUserInfo: true,
            userInfo: res.userInfo
          })
          wx.setStorageSync('userInfo', res.userInfo)
        }
      })
    } else {
      wx.showToast({
        title: '个人中心开发中',
        icon: 'none'
      })
    }
  }
}) 