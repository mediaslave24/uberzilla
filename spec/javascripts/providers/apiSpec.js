describe('api', function () {
  var api, $httpBackend, $injector;

  beforeEach(inject(function (_$injector_) {
    $injector = _$injector_;
    api = $injector.get('api');
    $httpBackend = $injector.get('$httpBackend');
  }));

  function expectRequest(fn, expArguments, responseArguments) {
    expect(function () {
      var response = $httpBackend.expect.apply($httpBackend, expArguments);
      response.respond.apply(response, responseArguments);
      fn();
      $httpBackend.flush();
    }).not.toThrow();
  }

  describe('standard resource routes', function () {
    describe('index', function () {
      it('makes request for list of resources', function () {
        expectRequest(
          api._resource('tables').index,
          ['GET', '/tables.json'],
          [200]
        );
      });
    });

    describe('show', function () {
      it('makes request for specific resource', function () {
        expectRequest(function () {
          api._resource('tables').show(244);
        }, ['GET', '/tables/244.json'], [200]);
      });
    });

    describe('create', function () {
      var params = {param1: 'param2'};

      it('makes POST request to create new resource', function () {
        expectRequest(function () {
          api._resource('tables').create(params);
        }, ['POST', '/tables.json', params], [200]);
      });
    });

    describe('destroy', function () {
      it('makes DELETE request to destroy specified resource', function () {
        expectRequest(function () {
          api._resource('tables').destroy(544);
        }, ['DELETE', '/tables/544.json'], [200]);
      });
    });

    describe('update', function () {
      var params = {a: 'b'};

      it('makes PUT request to update specific resource', function () {
        expectRequest(function () {
          api._resource('tables').update(12222, params);
        }, ['PUT', '/tables/12222.json', params], [200]);
      });
    });
  });
});
