/**
 * 작성자 : 김혜린
 */
 
 $(function(){
    // ==== 자물쇠 버튼 ====
    let lock = $(".lock-btn");
    let unlock = $(".unlock-btn");
    let lockSm = $(".sm-lock-btn");
    let unlockSm = $(".sm-unlock-btn");

    unlock.on('click', function(){
        // console.log("Locking...");
        unlock.css('display', 'none');
        lock.css('display', 'block');
    })

    lock.on('click', function(){
        // console.log("Unlocking...");
        unlock.css('display', 'block');
        lock.css('display', 'none');
    })

    unlockSm.on('click', function(){
        // console.log("Locking...");
        unlockSm.css('display', 'none');
        lockSm.css('display', 'block');
    })

    lockSm.on('click', function(){
        // console.log("Unlocking...");
        unlockSm.css('display', 'block');
        lockSm.css('display', 'none');
    })

    // ==== 댓글창 on/off ====
    $('.re-reply-btn').on('click', function(){
        if($('.re-btn-text').text() == "답글달기"){
            console.log("댓글창 열림")
            $('.re-btn-text').text("답글취소");
            $('.re-reply-input-area').css('display', 'flex');
        }else{
            console.log("댓글창 닫힘")
            $('.re-btn-text').text("답글달기");
            $('.re-reply-input-area').css('display', 'none');
        }
    })





    
})