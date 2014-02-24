######
# Core API functionality for all modules
######

######
# Module dependencies
######
http = require('http')
urlParser = require('url')
path = require('path')
qs = require('querystring')
i = require('util').inspect

module.exports = () ->
  end = true
  getEnd = () ->
    return this.end
  setEnd = (end) ->
    if end
      this.end = true
      return this.end
    else
      this.end = false
      return this.end
  message = null
  getMessage = ()->
    return this.response
  setMessage = (new_message) ->
    this.message = new_message
    return true
  format = 'json'
  getFormat = () ->
    return this.format
  setFormat = (new_format) ->
    if new_format=='xml' || new_format=='json'
      this.format = new_format
      return true
    else
      return false
  method = 'post'
  getMethod = () ->
    return this.method
  setMethod = (new_method='post') ->
    if new_method=='post' || new_method=='get'
      this.method = new_method
      return true
    else
      return false
  inputs = (
    'strippedText': null,
    'msisdn': null,
    'mobileText': null,
    'keywordName': null,
    'keywordId': null,
    'shortCode': null,
    'subscriberId': null,                  
    'metadataId': null,
    'oldValue': [],
    'newValue': null
  )

  strrpos = (haystack, needle, offset) ->
    i = -1
    if (offset) {
      i = (haystack + '').slice(offset).lastIndexOf(needle)
      if (i !== -1) {
        i += offset
      }
    } else {
      i = (haystack + '').lastIndexOf(needle)
    }
    return i >= 0 ? i : false
  }
  
  substr = (str, start, len) ->
    i = 0,
        allBMP = true,
        es = 0,
        el = 0,
        se = 0,
        ret = ''
      str += ''
      end = str.length
      
      this.php_js = this.php_js || {}
      this.php_js.ini = this.php_js.ini || {}
      switch ((this.php_js.ini['unicode.semantics'] && this.php_js.ini['unicode.semantics'].local_value.toLowerCase()))
        when 'on'
          for (i = 0; i < str.length; i++)
            if (/[\uD800-\uDBFF]/.test(str.charAt(i)) && /[\uDC00-\uDFFF]/.test(str.charAt(i + 1)))
              allBMP = false
              break
        
          if (!allBMP)
            if (start < 0)
              for (i = end - 1, es = (start += end); i >= es; i--)
                if (/[\uDC00-\uDFFF]/.test(str.charAt(i)) && /[\uD800-\uDBFF]/.test(str.charAt(i - 1)))
                  start--
                  es--
            else
              surrogatePairs = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g
              while ((surrogatePairs.exec(str)) != null)
                li = surrogatePairs.lastIndex
                if (li - 2 < start)
                  start++
                else
                  break
          
            if (start >= end || start < 0)
              return false
          
            if (len < 0)
              for (i = end - 1, el = (end += len); i >= el; i--)
                if (/[\uDC00-\uDFFF]/.test(str.charAt(i)) && /[\uD800-\uDBFF]/.test(str.charAt(i - 1)))
                  end--
                  el--
            
              if (start > end)
                return false
            
              return str.slice(start, end)
            else
              se = start + len
              for (i = start; i < se; i++)
                ret += str.charAt(i)
                if (/[\uD800-\uDBFF]/.test(str.charAt(i)) && /[\uDC00-\uDFFF]/.test(str.charAt(i + 1)))
                  se++
              return ret
        when 'off', else
          if (start < 0)
            start += end
          end = typeof len === 'undefined' ? end : (len < 0 ? len + end : len + start)
          return start >= str.length || start < 0 || start > end ? !1 : str.slice(start, end)
        return undefined
  
  stripText = (keyword, text_message) ->
    text_message.replace("/^('"+keyword+"\s+)/i", '', text_message)
  
  textTruncate = (text, length) ->
    if(text.length > length)
      text = substr(text, 0, numb)
      text = substr(text, 0, strrpos(text, " "))
      text = text
    return text

  ######
  # Expose public
  ######
  return {
    apiUrl: apiUrl,
    setMethod: setMethod
  }