Page({
  data: {
    selectedPhonetic: '',
    phoneticGroups: [
      {
        type: '单元音',
        items: [
          { symbol: 'iː', wordCount: 0 },
          { symbol: 'ɪ', wordCount: 0 },
          // ... 其他音标
        ]
      },
      {
        type: '双元音',
        items: [
          { symbol: 'eɪ', wordCount: 0 },
          { symbol: 'aɪ', wordCount: 0 },
          // ... 其他音标
        ]
      },
      {
        type: '辅音',
        items: [
          { symbol: 'p', wordCount: 0 },
          { symbol: 'b', wordCount: 0 },
          // ... 其他音标
        ]
      }
    ],
    words: [],
    viewMode: 'phonetic',
    studyRecords: []
  },

  onLoad() {
    this.loadWordCounts()
    this.loadStudyRecords()
  },

  // 加载每个音标下的单词数量
  loadWordCounts() {
    const knownWords = wx.getStorageSync('knownWords') || {}
    const phoneticGroups = this.data.phoneticGroups.map(group => ({
      ...group,
      items: group.items.map(item => ({
        ...item,
        wordCount: (knownWords[item.symbol] || []).length
      }))
    }))
    this.setData({ phoneticGroups })
  },

  // 选择音标
  selectPhonetic(e) {
    const { symbol } = e.currentTarget.dataset
    const knownWords = wx.getStorageSync('knownWords') || {}
    const words = knownWords[symbol] || []
    
    this.setData({
      selectedPhonetic: symbol,
      words: words.map(word => ({
        word: word,
        phonetic: symbol
      }))
    })
  },

  // 加载学习记录
  loadStudyRecords() {
    const allRecords = wx.getStorageSync('studyRecords') || []
    // 只显示标记为认识的记录
    const records = allRecords.filter(record => record.type === 'known')
    // 按时间倒序排序
    records.sort((a, b) => b.timestamp - a.timestamp)
    this.setData({ studyRecords: records })
  },

  // 切换到音标视图
  switchToPhonetic() {
    this.setData({ viewMode: 'phonetic' })
  },

  // 切换到历史记录视图
  switchToHistory() {
    this.setData({ viewMode: 'history' })
  }
}) 