//
//  EmojisCVDelegate.swift
//  FAStickers
//
//  Created by Faris Albalawi on 6/4/19.
//

import UIKit

class EmojisCVDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let emojiRanges = [
        0x1F601...0x1F64F,
        0x1F30D...0x1F567,
        0x1F680...0x1F6C0,
        0x1F681...0x1F6C5
    ]
    
    var emojis: [String] = []
    
    override init() {
        super.init()
        
        for range in emojiRanges {
            for i in range {
                let c = String(describing: UnicodeScalar(i)!)
                emojis.append(c)
            }
        }
    }
    
    var StickerEmojiDelegate : StickerEmojiDelegate?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmojiCell
        cell.emojiLabel.text = emojis[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        StickerEmojiDelegate?.EmojiTapped(EmojiName: emojis[indexPath.row])
        print(emojis[indexPath.row])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
