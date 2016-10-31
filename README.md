# iOS_Touches
iOS touches  相关测试
#touches
##**1.Touch Events and Views**
1.  multitouch sequence
		From that moment until the time the screen is once again finger-free, all touches and finger movements together constitute what Apple calls a single multitouch sequence.
2. UIEvent
	The system reports to your app, during a given multitouch sequence, **every change in finger configuration,** so that your app can figure out what the user is doing. Every such report is a UIEvent.

	In fact, every report having to do with the same multitouch sequence is the **same UIEvent instance, **arriving **repeatedly**, each time there’s a change in finger configuration.
3. UITouch 
	Every UIEvent reporting a change in the user’s finger configuration contains **one or more UITouch objects.**
	Each UITouch object **corresponds to a single finger**
	Once a UITouch instance has been created to represent a finger that has touched the screen, **the same UITouch instance** is used to represent that finger throughout this multitouch sequence until the finger leaves the screen.
4. UITouchPhase
	The system needs to report only changes in the finger configuration
	.Began
	.Moved
	.Stationary
	.Ended
	.Cancelled

##**2.Receiving Touches**
**A UIEvent is delivered to a view by calling one of these four methods (the touches methods):**
touchesBegan:withEvent:
touchesMoved:withEvent:
touchesEnded:withEvent:
touchesCancelled:withEvent:

**A UITouch has some useful methods and properties:**
locationInView:, previousLocationInView:
timestamp（时间戳）

##**3.Restricting Touches**
Touch events can be turned off entirely at the application level with UIApplication’s **beginIgnoringInteractionEvents**.（when animations）
**endIgnoringInteractionEvents**.

**A number of UIView properties also restrict the delivery of touches to particular views:**
**userInteractionEnabled**
**alpha**
	If set to 0.0 (or extremely close to it), this view (along with its subviews) is excluded from receiving touches
**hidden**
**multipleTouchEnabled**
**exclusiveTouch**
An exclusiveTouch view receives a touch only if no other views in the same window have touches associated with them
###**4.Gesture Recognizers**
 many types of gesture are conventional and standard; it seems insane to require developers to implement independently the elements that constitute what is, in effect, a universal vocabulary.
Thanks to gesture recognizers, it is unnecessary to subclass UIView merely in order to implement touch analysis.

###**Gesture Recognizer Classes**
A UIGestureRecognizer** implements the four touches handlers**
If, however, a new touch is going to be delivered to a view, i**t is also associated with and delivered to that view’s gesture recognizers** if it has any, and to that view’s superview’s gesture recognizers if it has any, and so on up the view hierarchy.

UITouch and UIEvent provide complementary ways of learning how touches and gesture recognizers are associated.
UITouch’s gestureRecognizers
UIEvent’s touchesForGestureRecognizer:

When one of them decides that it has rec‐ ognized its own particular type of gesture, it emits either a single message (to indicate, for example, that a finger has tapped) or a series of messages (to indicate, for example, that a finger is moving)	

A gesture recognizer implements a notion of states (the state property, UIGesture‐ RecognizerState);
**Wrong gesture **
.Possible → .Failed. No action message is sent.

**Discrete gesture (like a tap), recognized**
 .Possible → .Ended. One action message is sent, when the state changes to .Ended.

**Continuous gesture (like a drag), recognized**
 .Possible → .Began → .Changed (repeatedly) → .Ended. 
Action messages are sent once for .Began, as many times as necessary for .Changed, and once for .Ended.

**Continuous gesture, recognized but later cancelled **
.Possible → .Began → .Changed (repeatedly) → .Cancelled. 
Action messages are sent once for .Began, as many times as necessary for .Changed, and once for .Cancelled.

###**Gesture Recognizer Conflicts**
The question naturally arises of what happens when multiple gesture recognizers are in play. This isn’t a matter merely of multiple recognizers attached to a **single view**

In general, once a gesture recognizer succeeds in recognizing its gesture, any other gesture recognizers associated with its touches are forced into the .Failed state,

###**Subclassing Gesture Recognizers**
To subclass UIGestureRecognizer or a built-in gesture recognizer subclass, you must do the following things:
• Import UIKit.UIGestureRecognizerSubclass.
• Override any touches methods you need to (as if the gesture recognizer were a UIResponder)
通过设置gesture的state来进行设置

###**Gesture Recognizer Delegate**
gestureRecognizerShouldBegin:
Sent to the delegate before the gesture recognizer passes out of the .Possible state;
gestureRecognizer:shouldReceiveTouch:
Sent to the delegate before a touch is sent to the gesture recognizer’s touches- Began:withEvent: method

##**5.Touch Delivery**
Here’s the full standard procedure by which a touch is delivered to views and gesture recognizers:
• Whenever a new touch appears, the application performs hit-testing to determine the view that was touched. This view will be permanently associated with this touch, and is called, appropriately, the hit-test view. The logic of ignoring a view (denying it the ability to become the hit-test view) in response to its userInteraction- Enabled, hidden, and alpha properties is implemented at this stage.

• Each time the touch situation changes, the application calls its own sendEvent:, which in turn calls the window’s sendEvent:. The window delivers each of an event’s touches by calling the appropriate touches method(s), as follows:

■ As a touch first appears, the logic of obedience to multipleTouchEnabled and exclusiveTouch is considered. If permitted by that logic:

⚬ The touch is delivered to the hit-test view’s swarm of gesture recognizers.
⚬ The touch is delivered to the hit-test view itself. 
■ If a gesture is recognized by a gesture recognizer, then for any touch associated with this gesture recognizer:

⚬ touchesCancelled:forEvent: is sent to the touch’s view, and the touch is no longer delivered to its view. 
⚬ If that touch was associated with any other gesture recognizer, that gesture recognizer is forced to fail.

■ If a gesture recognizer fails, either because it declares failure or because it is forced to fail, its touches are no longer delivered to it, but (except as already specified) they continue to be delivered to their view.

■ If a touch would be delivered to a view, but that view does not respond to the appropriate touches method, a responder further up the responder chain is sought that does respond to it, and the touch is delivered there.

###**Hit-Testing**
Hit-testing is the determination of what view the user touched.
View hit-testing uses the UIView instance method **hitTest:withEvent:,** which returns either a view (the hit- test view) or nil. The idea is to find the frontmost view containing the touch point. This method uses an elegant **recursive** algorithm, as follows:
1. A view’s hitTest:withEvent: first calls the same method on its own **subviews**, if it has any, because a subview is considered to be in front of its superview. The subviews are queried in front-to-back order (Chapter 1): thus, if two sibling views overlap, the one in front reports the hit first.

2. If, as a view hit-tests its subviews, any of those subviews responds by returning a view, it stops querying its subviews and immediately returns the view that was returned to it. Thus, the very first view to declare itself the hit-test view immediately percolates all the way to the top of the call chain and is the hit-test view.

3. If, on the other hand, a view has no subviews, or if all of its subviews return nil (indicating that neither they nor their subviews was hit), then the view calls point- Inside:withEvent: on itself. If this call reveals that the touch was inside this view, the view returns itself, declaring itself the hit-test view; otherwise it returns nil.
###**Initial Touch Event Delivery**
When the touch situation changes, an event containing all touches is handed to the** UIApplication instance by calling its sendEvent:**, and the UIApplication in turn hands it to the relevant **UIWindow by calling its sendEvent:.** The UIWindow then performs the complicated logic of examining, for every touch, the hit-test view and its superviews and their gesture recognizers and **deciding which of them should be sent a touches message, and does so.**
###**Gesture Recognizer and View**
When a touch first appears and is delivered to a gesture recognizer, it is also delivered to its hit-test view, the same touches method being called on **both**.
Later, if a gesture recognizer in a view’s swarm recognizes its gesture, that view is sent** touchesCancelled:withEvent:** for any touches that went to that gesture recognizer and were hit-tested to that view, and subsequently the view no longer receives those touches.
if all the gesture recognizers in a view’s swarm declare failure to recognize their gesture, that view’s internal touch inter‐ pretation just proceeds as if gesture recognizers had never been invented.
 
Moreover, touches and gestures are** two different things**; sometimes you want to respond to **both**

This behavior can be changed by setting a gesture recognizer’s **cancelsTouchesInView** property to false.

Gesture recognizers can also delay the delivery of touches to a view, and by default they do. The UIGestureRecognizer property **delaysTouchesEnded** is true by default,（The reason for this behavior is most obvious with a gesture where multiple taps are required.）

###**Touch Exclusion Logic**
It is up to the UIWindow’s sendEvent: to implement the logic of **multipleTouchEnabled** and **exclusiveTouch**.
If a new touch is hit-tested to a view whose multipleTouchEnabled is false and which already has an existing touch hit-tested to it, then sendEvent: never delivers the new touch to that view. **However, that touch is delivered to the view’s swarm of gesture recognizers.**

Similarly, if there’s an exclusiveTouch view in the window, then sendEvent: must decide whether a particular touch should be delivered, in accordance with the meaning of exclusiveTouch, which I described earlier. **If a touch is not delivered to a view because of exclusiveTouch restrictions, it is not delivered to its swarm of gesture recognizers either.**

###**Gesture Recognition Logic**
When a gesture recognizer recognizes its gesture, everything changes. As we’ve already seen, the touches for this gesture recognizer are sent to their hit-test views as a touches- Cancelled:forEvent: message, and then no longer arrive at those views (unless the gesture recognizer’s cancelsTouchesInView is false). **Moreover, all other gesture recognizers pending with regard to these touches are made to fail**, and then are no longer sent the touches they were receiving either.
###**Touches and the Responder Chain**
A UIView is a responder, and participates in the responder chain. In particular, if a touch is to be delivered to a UIView (because, for example, it’s the hit-test view) and that view doesn’t implement the relevant touches method**, a walk up the responder chain is per‐ formed, looking for a responder that does implement it**; if such a responder is found, the touch is delivered to that responder. Moreover, the **default implementation** of the touches methods — the behavior that you get if you call super — is to **perform the same walk up the responder chain**, starting with the next responder in the chain.

The relationship between touch delivery and the responder chain can be useful, but you must be careful not to allow it to develop into an incoherency. For example, if touches- Began:withEvent: is implemented in a superview but not in a subview, then a touch to the subview will result in the superview’s touchesBegan:withEvent: being called, with the first parameter (the touches) containing a touch whose view is the subview. But most UIView implementations of the touches methods rely upon the assumption that the first parameter consists of all and only touches whose view is self; built-in UIView subclasses certainly assume this.

Again, if touchesBegan:withEvent: is implemented in both a superview and a subview, and you call super in the subview’s implementation, passing along the same arguments that came in, then the same touch delivered to the subview will trigger both the subview’s touchesBegan:withEvent: and the superview’s touchesBegan:withEvent: (and once again the first parameter to the superview’s touchesBegan:withEvent: will contain a touch whose view is the subview).






