// MIT License
//
// Copyright 2017 Electric Imp
//
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
// "Promise" symbol is injected dependency from ImpUnit_Promise module,
// while class being tested can be accessed from global scope as "::Promise".

@include "github:electricimp/Rocky/Rocky.class.nut"

// CoreRockyMethod
// Tests for Rocky.on, Rocky.VERB
// Should be included into file, witch contains getVerb() function
class CoreRockyMethod extends ImpTestCase {

    @include __PATH__+"/Core.nut"
    @include __PATH__+"/CoreHandlers.nut"

    values = null;
    
    function setUp() {
        this.values = [null, true, 0, -1, 1, 13.37, "String", [1, 2], {"counter": "this"}, blob(64), function(){}];
        this.info("Test for VERB: " + getVerb());
    }

    function testInvalidParamsMethod() {
        local tests = [];
        foreach (element in this.values) {
            tests.push({
                "signature": "/testInvalidParamsMethod", 
                "method": element,
                "methodOverride": getVerb(),
                "onExceptionApp": onException.bindenv(this)
            });
        }
        tests.push({
            "signature": "/testInvalidParamsMethod", 
            "method": "#" + getVerb(),
            "methodOverride": getVerb(),
            "onExceptionApp": onException.bindenv(this)
        });
        return createTestAll(tests);
    }

    function testInvalidParamsSignature() {
        local tests = [];
        foreach (element in this.values) {
            tests.push({
                "signature": element, 
                "method": getVerb(),
                "onExceptionApp": onException.bindenv(this)
            });
        }
        return createTestAll(tests);
    }

    function testInvalidParamsCallback() {
        local tests = [];
        foreach (element in this.values) {
            tests.push({
                "signature": "/testInvalidParamsCallback",
                "method": getVerb(),
                "cb": element,
                "onExceptionApp": onException.bindenv(this)
            });
        }
        return createTestAll(tests);
    }

    function testInvalidParamsTimeout() {
        local tests = [];
        foreach (element in this.values) {
            tests.push({
                "signature": "/testInvalidParamsTimeout",
                "method": getVerb(),
                "timeoutRoute": element,
                "onExceptionApp": onException.bindenv(this)
            });
        }
        return createTestAll(tests);
    }
}
