require 'spec_helper'

describe 'Routes' do
  describe '/users' do
    context 'when the username has a period' do
      it 'routes' do
        expect(get: '/users/alfred.e.newman').to route_to(
          action: 'show',
          controller: 'users',
          id: 'alfred.e.newman'
        )
      end
    end

    context 'when the username has a space' do
      it 'routes' do
        expect(get: '/users/james%20bond').to route_to(
          action: 'show',
          controller: 'users',
          id: 'james bond'
        )
      end
    end

    context 'when the username has an underscore' do
      it 'routes' do
        expect(get: '/users/jim_henson').to route_to(
          action: 'show',
          controller: 'users',
          id: 'jim_henson'
        )
      end
    end
  end
end
