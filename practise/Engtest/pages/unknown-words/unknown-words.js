Page({
  data: {
    selectedPhonetic: '',
    phoneticGroups: [
      {
        type: '单元音',
        items: [
          { symbol: 'iː', wordCount: 0 },
          { symbol: 'ɪ', wordCount: 0 },
          { symbol: 'e', wordCount: 0 },
          { symbol: 'æ', wordCount: 0 },
          { symbol: 'ɑː', wordCount: 0 },
          { symbol: 'ɒ', wordCount: 0 },
          { symbol: 'ɔː', wordCount: 0 },
          { symbol: 'ʊ', wordCount: 0 },
          { symbol: 'uː', wordCount: 0 },
          { symbol: 'ʌ', wordCount: 0 },
          { symbol: 'ɜː', wordCount: 0 },
          { symbol: 'ə', wordCount: 0 }
        ]
      },
      {
        type: '双元音',
        items: [
          { symbol: 'eɪ', wordCount: 0 },
          { symbol: 'aɪ', wordCount: 0 },
          { symbol: 'ɔɪ', wordCount: 0 },
          { symbol: 'aʊ', wordCount: 0 },
          { symbol: 'əʊ', wordCount: 0 },
          { symbol: 'ɪə', wordCount: 0 },
          { symbol: 'eə', wordCount: 0 },
          { symbol: 'ʊə', wordCount: 0 }
        ]
      },
      {
        type: '辅音',
        items: [
          { symbol: 'p', wordCount: 0 },
          { symbol: 'b', wordCount: 0 },
          { symbol: 't', wordCount: 0 },
          { symbol: 'd', wordCount: 0 },
          { symbol: 'k', wordCount: 0 },
          { symbol: 'ɡ', wordCount: 0 },
          { symbol: 'f', wordCount: 0 },
          { symbol: 'v', wordCount: 0 },
          { symbol: 'θ', wordCount: 0 },
          { symbol: 'ð', wordCount: 0 },
          { symbol: 's', wordCount: 0 },
          { symbol: 'z', wordCount: 0 },
          { symbol: 'ʃ', wordCount: 0 },
          { symbol: 'ʒ', wordCount: 0 },
          { symbol: 'h', wordCount: 0 },
          { symbol: 'm', wordCount: 0 },
          { symbol: 'n', wordCount: 0 },
          { symbol: 'ŋ', wordCount: 0 },
          { symbol: 'l', wordCount: 0 },
          { symbol: 'r', wordCount: 0 },
          { symbol: 'j', wordCount: 0 },
          { symbol: 'w', wordCount: 0 }
        ]
      }
    ],
    words: []
  },

  onLoad() {
    this.loadWordCounts()
  },

  // 加载每个音标下的单词数量
  loadWordCounts() {
    const unknownWords = wx.getStorageSync('unknownWords') || {}
    const phoneticGroups = this.data.phoneticGroups.map(group => ({
      ...group,
      items: group.items.map(item => ({
        ...item,
        wordCount: (unknownWords[item.symbol] || []).length
      }))
    }))
    this.setData({ phoneticGroups })
  },

  // 选择音标
  selectPhonetic(e) {
    const { symbol } = e.currentTarget.dataset
    const unknownWords = wx.getStorageSync('unknownWords') || {}
    const words = unknownWords[symbol] || []
    
    this.setData({
      selectedPhonetic: symbol,
      words: words.map(word => ({
        word: word,
        phonetic: symbol
      }))
    })
  }
}) 