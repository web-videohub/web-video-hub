package com.teamrocket.videohub.api;

import com.teamrocket.videohub.entity.Subscription;
import com.teamrocket.videohub.services.SubscribeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.constraints.PastOrPresent;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/subscribe")
public class SubscribeApiController {
    private final SubscribeService subscribeService;

    // 구독 조회 기능
    @GetMapping("/{userAccount}/{receiverAccount}")
    public ResponseEntity<?> getSubs(@PathVariable String userAccount,
                                     @PathVariable String receiverAccount) {
        log.info("/api/v1/subscribe : GET!");
        Subscription subs = new Subscription(userAccount, receiverAccount);
        log.info("잘 가져왔니1: {}", subs);
        Subscription subs2 = subscribeService.findSubs(subs);
        log.info("잘 가져왔니2: {}", subs2);
        boolean flag = false;
        if (subs.equals(subs2)) {
            flag = true;
        }

        return ResponseEntity.ok().body(flag);
    }

    // 구독 추가 기능
    @PostMapping
    public ResponseEntity<?> addSubscribe(
            @Validated @RequestBody Subscription subs,
            BindingResult result,
            HttpSession session) {
        if(result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString());
        }

        log.info("/api/v1/subscribe : POST!");
        log.debug("Subscription : {}", subs);

        boolean flag = subscribeService.AddSubs(subs);

        return ResponseEntity.ok().body(flag);
    }

    // 구독 취소(삭제) 기능
    @DeleteMapping("{userAccount}/{receiverAccount}")
    public ResponseEntity<?> removeSubscribe(@PathVariable String userAccount,
                                             @PathVariable String receiverAccount) {
        log.info("/api/v1/subscribe{}/{} : DELETE!", userAccount, receiverAccount);

        Subscription subs = new Subscription(userAccount, receiverAccount);

        subscribeService.RemoveSubs(subs);

        return ResponseEntity.ok().body(false);
    }
}
