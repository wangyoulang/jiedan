Page({
  data: {
    userInfo: null,
    studyStats: {
      totalWords: 0,
      knownWords: 0,
      unknownWords: 0
    },
    recentActivity: []
  },

  onLoad() {
    // 获取用户信息
    const userInfo = wx.getStorageSync('userInfo')
    if (userInfo) {
      this.setData({ userInfo })
    }
    this.loadStudyStats()
    this.loadRecentActivity()
  },

  // 加载学习统计
  loadStudyStats() {
    const knownWords = wx.getStorageSync('knownWords') || {}
    const unknownWords = wx.getStorageSync('unknownWords') || {}
    
    let knownCount = 0
    let unknownCount = 0
    
    // 计算认识的单词总数
    Object.values(knownWords).forEach(words => {
      knownCount += words.length
    })
    
    // 计算不认识的单词总数
    Object.values(unknownWords).forEach(words => {
      unknownCount += words.length
    })
    
    this.setData({
      'studyStats.totalWords': knownCount + unknownCount,
      'studyStats.knownWords': knownCount,
      'studyStats.unknownWords': unknownCount
    })
  },

  // 加载最近活动
  loadRecentActivity() {
    const studyRecords = wx.getStorageSync('studyRecords') || []
    // 只显示最近10条记录
    const recentActivity = studyRecords
      .sort((a, b) => b.timestamp - a.timestamp)
      .slice(0, 10)
    this.setData({ recentActivity })
  },

  // 重新登录
  async handleReLogin() {
    try {
      const { userInfo } = await wx.getUserProfile({
        desc: '用于完善用户资料'
      })
      this.setData({ userInfo })
      wx.setStorageSync('userInfo', userInfo)
    } catch (error) {
      console.error('获取用户信息失败：', error)
      wx.showToast({
        title: '获取用户信息失败',
        icon: 'none'
      })
    }
  }
}) 