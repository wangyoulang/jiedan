Page({
  data: {
    showPhoneticList: false,
    selectedPhonetic: '选择音标',
    wordList: [],
    currentIndex: 0,
    loading: false,
    phoneticList: [
      // 元音
      { type: '单元音', items: [
        { symbol: 'iː', example: 'eat /iːt/' },
        { symbol: 'ɪ', example: 'it /ɪt/' },
        { symbol: 'e', example: 'bed /bed/' },
        { symbol: 'æ', example: 'cat /kæt/' },
        { symbol: 'ɑː', example: 'arm /ɑːm/' },
        { symbol: 'ɒ', example: 'hot /hɒt/' },
        { symbol: 'ɔː', example: 'saw /sɔː/' },
        { symbol: 'ʊ', example: 'put /pʊt/' },
        { symbol: 'uː', example: 'too /tuː/' },
        { symbol: 'ʌ', example: 'cup /kʌp/' },
        { symbol: 'ɜː', example: 'bird /bɜːd/' },
        { symbol: 'ə', example: 'about /əˈbaʊt/' }
      ]},
      // 双元音
      { type: '双元音', items: [
        { symbol: 'eɪ', example: 'face /feɪs/' },
        { symbol: 'aɪ', example: 'price /praɪs/' },
        { symbol: 'ɔɪ', example: 'boy /bɔɪ/' },
        { symbol: 'aʊ', example: 'mouth /maʊθ/' },
        { symbol: 'əʊ', example: 'goat /ɡəʊt/' },
        { symbol: 'ɪə', example: 'near /nɪə/' },
        { symbol: 'eə', example: 'square /skweə/' },
        { symbol: 'ʊə', example: 'poor /pʊə/' }
      ]},
      // 辅音
      { type: '辅音', items: [
        { symbol: 'p', example: 'pen /pen/' },
        { symbol: 'b', example: 'bad /bæd/' },
        { symbol: 't', example: 'tea /tiː/' },
        { symbol: 'd', example: 'did /dɪd/' },
        { symbol: 'k', example: 'cat /kæt/' },
        { symbol: 'ɡ', example: 'get /ɡet/' },
        { symbol: 'f', example: 'fall /fɔːl/' },
        { symbol: 'v', example: 'voice /vɔɪs/' },
        { symbol: 'θ', example: 'thin /θɪn/' },
        { symbol: 'ð', example: 'this /ðɪs/' },
        { symbol: 's', example: 'see /siː/' },
        { symbol: 'z', example: 'zoo /zuː/' },
        { symbol: 'ʃ', example: 'she /ʃiː/' },
        { symbol: 'ʒ', example: 'vision /ˈvɪʒn/' },
        { symbol: 'h', example: 'hot /hɒt/' },
        { symbol: 'm', example: 'man /mæn/' },
        { symbol: 'n', example: 'no /nəʊ/' },
        { symbol: 'ŋ', example: 'sing /sɪŋ/' },
        { symbol: 'l', example: 'leg /leɡ/' },
        { symbol: 'r', example: 'red /red/' },
        { symbol: 'j', example: 'yes /jes/' },
        { symbol: 'w', example: 'wet /wet/' }
      ]}
    ],
    studyRecords: []
  },

  // 选择音标时触发API请求
  async selectPhonetic(e) {
    const { symbol } = e.currentTarget.dataset
    this.setData({
      selectedPhonetic: symbol,
      showPhoneticList: false,
      loading: true,
      wordList: [],
      currentIndex: 0
    })
    await this.fetchWordsByPhonetic(symbol)
  },

  // 获取单词列表
  async fetchWordsByPhonetic(phonetic) {
    try {
      const result = await new Promise((resolve, reject) => {
        wx.request({
          url: 'https://yuanqi.tencent.com/openapi/v1/agent/chat/completions',
          method: 'POST',
          header: {
            'X-Source': 'openapi',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer RrdqW5gAywtRnzfkSaHCqQvOS3rEPUJr'
          },
          data: {
            "assistant_id": "Yxo4uBVMvBi3",
            "user_id": "phonetic_user",
            "stream": false,
            "messages": [
              {
                "role": "user",
                "content": [
                  {
                    "type": "text",
                    "text": `请给我50个包含音标${phonetic}的英文单词，只需要返回单词，用英文逗号分隔，不要返回其他任何内容。`
                  }
                ]
              }
            ]
          },
          success: (res) => {
            console.log('Raw API Response:', res)
            resolve(res)
          },
          fail: (error) => {
            console.error('API Request Failed:', error)
            reject(error)
          }
        })
      })

      if (result.statusCode === 200 && result.data) {
        console.log('API Data:', result.data)
        
        // 检查返回数据的结构
        if (result.data.choices && result.data.choices[0] && result.data.choices[0].message) {
          const content = result.data.choices[0].message.content
          console.log('Content:', content)
          
          const words = content.split(',').map(word => word.trim()).filter(word => word)
          console.log('Parsed Words:', words)
          
          const wordObjects = words.map(word => ({
            word: word,
            phonetic: this.data.selectedPhonetic
          }))

          this.setData({
            wordList: wordObjects,
            loading: false
          })
        } else {
          console.error('Invalid API Response Structure:', result.data)
          throw new Error('API返回数据格式不正确')
        }
      } else {
        console.error('Invalid Status Code or No Data:', result)
        throw new Error(`API请求失败: ${result.statusCode}`)
      }
    } catch (error) {
      console.error('完整错误信息：', error)
      wx.showToast({
        title: error.message || '获取单词失败',
        icon: 'none'
      })
      this.setData({ loading: false })
    }
  },

  // 切换到上一个单词
  prevWord() {
    if (this.data.currentIndex > 0) {
      this.setData({
        currentIndex: this.data.currentIndex - 1
      })
    }
  },

  // 切换到下一个单词
  nextWord() {
    if (this.data.currentIndex < this.data.wordList.length - 1) {
      this.setData({
        currentIndex: this.data.currentIndex + 1
      })
    }
  },

  // 标记为认识
  knowWord() {
    const word = this.data.wordList[this.data.currentIndex].word
    const phonetic = this.data.selectedPhonetic
    const timestamp = new Date().getTime()
    
    // 获取已存储的认识的单词
    const knownWords = wx.getStorageSync('knownWords') || {}
    if (!knownWords[phonetic]) {
      knownWords[phonetic] = []
    }
    
    // 添加新单词到列表中（如果不存在）
    if (!knownWords[phonetic].includes(word)) {
      knownWords[phonetic].push(word)
      wx.setStorageSync('knownWords', knownWords)

      // 添加到学习记录
      const studyRecords = wx.getStorageSync('studyRecords') || []
      studyRecords.push({
        word: word,
        phonetic: phonetic,
        type: 'known',
        timestamp: timestamp,
        date: new Date().toLocaleDateString()
      })
      wx.setStorageSync('studyRecords', studyRecords)
    }
    
    // 从不认识的单词列表中移除（如果存在）
    const unknownWords = wx.getStorageSync('unknownWords') || {}
    if (unknownWords[phonetic]) {
      const index = unknownWords[phonetic].indexOf(word)
      if (index > -1) {
        unknownWords[phonetic].splice(index, 1)
        wx.setStorageSync('unknownWords', unknownWords)
      }
    }
    
    this.nextWord()
  },

  // 标记为不认识
  unknownWord() {
    const word = this.data.wordList[this.data.currentIndex].word
    const phonetic = this.data.selectedPhonetic
    const timestamp = new Date().getTime()
    
    // 获取已存储的不认识的单词
    const unknownWords = wx.getStorageSync('unknownWords') || {}
    if (!unknownWords[phonetic]) {
      unknownWords[phonetic] = []
    }
    
    // 添加新单词到列表中（如果不存在）
    if (!unknownWords[phonetic].includes(word)) {
      unknownWords[phonetic].push(word)
      wx.setStorageSync('unknownWords', unknownWords)

      // 添加到学习记录
      const studyRecords = wx.getStorageSync('studyRecords') || []
      studyRecords.push({
        word: word,
        phonetic: phonetic,
        type: 'unknown',
        timestamp: timestamp,
        date: new Date().toLocaleDateString()
      })
      wx.setStorageSync('studyRecords', studyRecords)
    }
    
    // 从认识的单词列表中移除（如果存在）
    const knownWords = wx.getStorageSync('knownWords') || {}
    if (knownWords[phonetic]) {
      const index = knownWords[phonetic].indexOf(word)
      if (index > -1) {
        knownWords[phonetic].splice(index, 1)
        wx.setStorageSync('knownWords', knownWords)
      }
    }
    
    this.nextWord()
  },

  togglePhoneticList() {
    this.setData({
      showPhoneticList: !this.data.showPhoneticList
    })
  }
}) 